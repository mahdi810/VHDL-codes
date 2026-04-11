----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 12:19:37 AM
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_tb is
end pwm_tb;

architecture bhv of pwm_tb is
    component pwm is
        generic(NBIT : integer := 12); 
    port (
        reset, enable : in std_logic; 
        clk : in std_logic;
        pval : in unsigned(NBIT -1  downto 0); 
        pwmout : out std_logic
    );
    end component pwm;
    constant NBIT : integer := 12; 
    signal clk, pwmout, reset, enable : std_logic := '0';
    signal pval : unsigned((NBIT -1)  downto 0) := (others => '0');
    constant clk_period : time := 10 ns;

begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : entity work.pwm
        generic map(NBIT => NBIT)
        port map(
            clk => clk,
            reset => reset, 
            enable => enable, 
            pval => pval,
            pwmout => pwmout
        ); 

        --stimulus process 
        stim_p : process 
        begin 
            pval <= x"AAA"; 
            reset <= '0'; 
            enable <= '0';
            wait for clk_period * 2; 
            enable <= '1'; 
            wait for clk_period * 3; 
            reset <= '1'; 
            wait for clk_period * 2; 
            reset <= '0'; 
            wait for clk_period * 10; 


        wait; 
        end process stim_p; 

end bhv;
