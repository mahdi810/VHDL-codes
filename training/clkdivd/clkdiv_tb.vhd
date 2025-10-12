-- Engineer : Mohammad Mahdi Mohammadi 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_freq_divider is
end entity;

architecture sim of tb_freq_divider is
    -- Signals for connecting to DUT (Device Under Test)
    signal clk_tb       : std_logic := '0';
    signal reset_tb     : std_logic := '0';
    signal pulse_rot_tb : std_logic;

    -- Clock period (100 MHz  10 ns)
    constant CLK_PERIOD : time := 10 ns;
begin
    ------------------------------------------------------------------------
    -- Instantiate the frequency divider
    ------------------------------------------------------------------------
    uut: entity work.freq_divider
        generic map(
            MAX_COUNT => 4  -- Small value for simulation
        )
        port map(
            clk       => clk_tb,
            reset     => reset_tb,
            pulse_rot => pulse_rot_tb
        );

    ------------------------------------------------------------------------
    -- Clock generation
    ------------------------------------------------------------------------
    clk_process : process
    begin
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
    end process;

    ------------------------------------------------------------------------
    -- Stimulus process
    ------------------------------------------------------------------------
    stim_proc : process
    begin
        -- Apply reset
        reset_tb <= '1';
        wait for 30 ns;
        reset_tb <= '0';

        -- Let the simulation run
        wait for 400 ns;
        wait;
    end process;
end architecture sim;