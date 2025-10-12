-- Engineer: Mohammad Mahdi Mohammadi
-- Module Name: spitop_tb - Behavioral
-- Description: SPI master top-level file
-- BTND (reset) => reset the state machine
-- BTNC (start) => start the transmission
-- input data (sndData) => data to be sent
-- output data (rcvData)=>
-------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity spitop_tb is
end spitop_tb;

architecture Behavioral of spitop_tb is

    component spitop is
        Port (
            reset   : in  STD_LOGIC;
            start   : in  STD_LOGIC;
            bclk    : in  STD_LOGIC;
            sndData : in  STD_LOGIC_VECTOR (7 downto 0);
            rcvData : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    signal reset   : std_logic := '0';
    signal start   : std_logic := '0';
    signal bclk    : std_logic := '0';
    signal sndData : std_logic_vector (7 downto 0) := x"A5";
    signal rcvData : std_logic_vector (7 downto 0) := x"00";
    constant clk_period : time := 10 ns;

begin

    uut: spitop
        port map (
            reset   => reset,
            start   => start,
            bclk    => bclk,
            sndData => sndData,
            rcvData => rcvData
        );

    clk_p : process
    begin
        bclk <= '0';
        wait for clk_period/2;
        bclk <= '1';
        wait for clk_period/2;
    end process clk_p;

    stim_p : process
    begin
        wait for clk_period;
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait;
    end process stim_p;

end Behavioral;