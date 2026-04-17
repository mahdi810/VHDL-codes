----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2026 11:38:40 PM
-- Design Name: 
-- Module Name: fsm5_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity fsm5_tb is
end fsm5_tb;

architecture Behavioral of fsm5_tb is
    component fsm5 is
        Port ( 
            clk, s : in std_logic; 
            xy : out std_logic_vector(1 downto 0) );
    end component fsm5;
    signal clk, s : std_logic := '0'; 
    signal xy : std_logic_vector(1 downto 0) := "00"; 
    constant clk_period : time := 10 ns; 
begin

    --clock generatin 
    clk_p : process
    begin 
        clk <= '0'; 
        wait for clk_period/2; 
        clk <= '1'; 
        wait for clk_period/2; 
    end process clk_p; 
    
    --unit under test 
    uut : fsm5
    port map( clk => clk, 
              s => s, 
              xy => xy ); 
              
    --stimulus process 
    stim_p : process 
    begin 
        s <= '0'; 
        for k in 0 to 10 loop 
            wait for clk_period; 
        end loop; 
        s <= '1'; 
        for k in 0 to 10 loop 
            wait for clk_period; 
        end loop;  
    
        wait; 
    end process stim_p; 

end Behavioral;
