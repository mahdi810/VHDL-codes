------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi
-- Create Date: 06/03/2025 11:49:47 AM
-- Module Name: spicpol0cph1 - Behavioral
-- Description: SPI transmitter cpol=0, cphase=1, 8bit.
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity spicpol0chp1 is
    Port (
        reset    : in  STD_LOGIC;
        bclk     : in  STD_LOGIC;
        start    : in  STD_LOGIC;
        done     : out STD_LOGIC;
        scsq     : out STD_LOGIC;
        sclk     : out STD_LOGIC;
        sdi      : in  STD_LOGIC;
        sdo      : out STD_LOGIC;
        sndData  : in  STD_LOGIC_VECTOR (7 downto 0);
        rcvData  : out STD_LOGIC_VECTOR (7 downto 0)
    );
end spicpol0chp1;

architecture Behavioral of spicpol0chp1 is
    constant SPI_NBITS : integer := 8;
    type STATE_TYPE is (sidle, sstartx, sstart_lo, sclk_hi, sclk_lo, sstop_hi, sstop_lo);
    signal state, next_state : STATE_TYPE;
    signal scsq_i, sclk_i, sdo_i : STD_LOGIC;
    signal lshift : STD_LOGIC;
    signal start_i : STD_LOGIC;
    signal wr_buf : STD_LOGIC_VECTOR (SPI_NBITS - 1 downto 0);
    signal rd_buf : STD_LOGIC_VECTOR (SPI_NBITS - 1 downto 0);
    signal count : integer range 0 to SPI_NBITS - 1;
    -- for simulation
    constant clk_div : integer := 3;
    -- for hardware test 5 bits/sec transmission rate
    -- constant CLK_DIV : integer := 9999999;
    subtype counter_type is integer range 0 to clk_div;
    signal spi_clkp : STD_LOGIC;
begin

    -- Clock divider process
    clkdiv_p : process(bclk)
        variable cnt : counter_type := clk_div;
    begin
        if rising_edge(bclk) then
            spi_clkp <= '0';
            if cnt = 0 then
                spi_clkp <= '1';
                cnt := clk_div;
            else
                cnt := cnt - 1;
            end if;
        end if;
    end process clkdiv_p;

    rcvData <= rd_buf;

    -- Sequential process
    seq_p : process(bclk)
    begin
        if rising_edge(bclk) then
            start_i <= start;
            if reset = '1' then
                state <= sidle;
                sclk <= '0';
                sdo  <= '0';
            else
                if next_state = sstartx then
                    count  <= SPI_NBITS - 1;
                    wr_buf <= sndData;
                elsif next_state = sclk_hi then
                    count <= count - 1;
                elsif next_state = sclk_lo then
                    wr_buf <= wr_buf(SPI_NBITS-2 downto 0) & '-';
                    rd_buf <= rd_buf(SPI_NBITS-2 downto 0) & sdi;
                elsif next_state = sstop_lo then
                    rd_buf <= rd_buf(SPI_NBITS-2 downto 0) & sdi;
                end if;
                state <= next_state;
                scsq <= scsq_i;
                sclk <= sclk_i;
                sdo  <= sdo_i;
            end if;
        end if;
    end process seq_p;

    -- Combinational process
    cmb_p : process(state, start_i, count, wr_buf)
    begin
        next_state <= state;
        scsq_i     <= '0';
        sclk_i     <= '0';
        sdo_i      <= '0';
        done       <= '0';
        case state is
            when sidle =>
                done   <= '1';
                scsq_i <= '1';
                if start_i = '1' then
                    next_state <= sstartx;
                end if;
            when sstartx =>
                next_state <= sstart_lo;
            when sstart_lo =>
                sclk_i <= '1';
                sdo_i  <= wr_buf(SPI_NBITS - 1);
                next_state <= sclk_hi;
            when sclk_hi =>
                sdo_i  <= wr_buf(SPI_NBITS - 1);
                next_state <= sclk_lo;
            when sclk_lo =>
                sclk_i <= '1';
                sdo_i  <= wr_buf(SPI_NBITS - 1);
                if count = 0 then
                    next_state <= sstop_hi;
                else
                    next_state <= sclk_hi;
                end if;
            when sstop_hi =>
                sdo_i  <= wr_buf(SPI_NBITS - 1);
                next_state <= sstop_lo;
            when sstop_lo =>
                scsq_i <= '1';
                next_state <= sidle;
        end case;
    end process cmb_p;

end Behavioral;