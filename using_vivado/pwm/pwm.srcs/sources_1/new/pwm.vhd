----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2026 12:19:22 AM
-- Design Name: 
-- Module Name: pwm - Behavioral
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

entity pwm is
    generic(NBIT : integer := 12); 
    port (
        reset, enable : in std_logic; 
        clk : in std_logic;
        pval : in unsigned(NBIT -1  downto 0); 
        pwmout : out std_logic
    );
end pwm;

architecture bhv of pwm is 
subtype int12_t is integer range 0 to 2**NBIT - 1; 
signal count : int12_t := 0; 
signal pval_in : int12_t := 0; 

begin 

    pval_in <= to_integer(pval); 
    
    --free running counter process 
    counter : process(clk)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                count <= 0; 
            else 
                if enable = '1' then
                    if count = (2**NBIT)-1 then 
                        count <= 0; 
                    else
                    count <= count + 1; 
                    end if;
                end if;  
            end if; 
        end if; 
    end process counter; 
    
    pwmout <= '1' when pval_in > count else '0';  


end bhv; 