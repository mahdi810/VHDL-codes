----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2025 04:17:56 PM
-- Design Name: 
-- Module Name: pwm2_tb - Behavioral
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

entity pwm2_tb is
end pwm2_tb;

architecture bhv of pwm2_tb is 
    component pwm2 is 
        Port ( pval : in UNSIGNED(11 downto 0);
               pwmout : out STD_LOGIC;
               reset : in STD_LOGIC;
               clk : in STD_LOGIC;
               enable : in STD_LOGIC); 
    end component pwm2; 
    signal clk, reset, enable, pwmout : std_logic := '0';
    signal pval : UNSIGNED(11 downto 0) := (others => '0'); 

    constant clk_periode : time := 10 ns; 

begin 

    --clock generation 
    clk_p : process 
    begin 
        clk <= '0'; 
        wait for clk_periode/2; 
        clk <= '1'; 
        wait for clk_periode/2; 
    end process clk_p; 

    uut : pwm2
        port map( clk =>  clk, 
                  reset => reset, 
                  enable => enable, 
                  pwmout => pwmout, 
                  pval => pval); 

    stim_p : process 
    begin 
        reset <= '0'; 
        enable <= '1'; 
        pval <= x"AAA"; 
        wait for 1 ms;
        reset <=  '1'; 
        enable <= '0'; 
        wait for clk_periode* 5; 
        wait; 
    end process stim_p; 



end bhv; 




