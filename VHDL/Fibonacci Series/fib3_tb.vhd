library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fib3_tb is
end entity;

architecture bhv of fib3_tb is

    component fib3 is
        port (clk, reset, start : in std_logic; 
          y_out : out unsigned(31 downto 0);
          n : in integer;  
          done : out std_logic ); 
    end component;

    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
    signal start : std_logic := '0';
    signal n     : integer := 0;
    signal y_out : unsigned(31 downto 0) := (others => '0');

    constant clk_period : time := 10 ns;

begin

    -- Clock generation process
    clk_p : process
    begin
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
    end process clk_p;

    -- Unit Under Test (UUT) instantiation
    uut: fib3
        port map (
            clk    => clk,
            reset  => reset,
            start  => start,
            n      => n,
            y_out  => y_out
        );

    -- Stimulus process
    stim_p : process
    begin
        -- Initialize signals
        reset <= '1';
        start <= '0';
        n <= 15;  -- Calculate first 15 Fibonacci terms
        wait for clk_period * 2;

        reset <= '0';
        wait for clk_period * 2;

        start <= '1';   -- Start calculation
        wait for clk_period*30;

        start <= '0';   -- Clear start after one clock period

        -- Wait long enough to finish calculation (at least n clock cycles)
        wait for clk_period * 30;

        -- End simulation
        wait;
    end process stim_p;

    -- Optional: Monitor output at each rising clock edge
    monitor_p : process(clk)
    begin
        if rising_edge(clk) then
            report "Fibonacci Output: " & integer'image(to_integer(y_out));
        end if;
    end process monitor_p;

end architecture;
