----------------------------------------------------------------------------------
-- Company: HS Bremerhaven
-- Engineer: Mohammad Mahdi Mohammadi
-- 
-- Create Date: 09/03/2025 07:17:18 PM
-- Design Name: Finite State Machine of exponential algorithm
-- Module Name: fsmexp - Behavioral
-- Description: calculation of approximate exponential value using iteration
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsmexp_tb is
end fsmexp_tb;

architecture testbench of fsmexp_tb is
    component fsmexp is
        port(
            clk   : in  std_logic;
            reset : in  std_logic;
            start : in  std_logic;
            u_in  : in  std_logic_vector(15 downto 0);
            u_out : out std_logic_vector(15 downto 0);
            done  : out std_logic
        );
    end component;

    signal clk      : std_logic := '0';
    signal reset    : std_logic := '1';
    signal start    : std_logic := '0';
    signal u_in     : std_logic_vector(15 downto 0) := (others => '0');
    signal u_out    : std_logic_vector(15 downto 0);
    signal done     : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    dut: fsmexp
        port map (
            clk   => clk,
            reset => reset,
            start => start,
            u_in  => u_in,
            u_out => u_out,
            done  => done
        );

    clk_process : process
    begin
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
    end process;

    stimulus_process : process
    begin
        u_in <= x"0300"; --u_in = 1.5 in int16.9
        reset <= '1'; 
        wait for clk_period; 
        reset <= '0'; 
        wait for clk_period;
        start <= '1'; 
        wait for clk_period * 20; 
        wait;
    end process;

end testbench;