----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2025 04:06:25 PM
-- Design Name: 
-- Module Name: pwm2 - Behavioral
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

entity pwm2 is
    Port ( pval : in UNSIGNED(11 downto 0);
           pwmout : out STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : in STD_LOGIC);
end pwm2;

architecture Behavioral of pwm2 is
    SIGNAL counter : UNSIGNED(11 downto 0) := (others => '0'); 
    
begin

    --counter process
    counter_p : process(clk, enable, reset) 
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                counter <= (others => '0'); 
            else 
                if enable = '1' then 
                    counter <= counter + 1; 
                end if; 
            end if;
        end if; 
    end process counter_p; 
    
    
    pwm_p : process(clk, reset, enable)
    begin 
        if rising_edge(clk) then 
            if reset = '0' AND enable = '1' then 
                if pval > counter then 
                    pwmout <= '1'; 
                else 
                    pwmout <= '0';
                end if;
            else 
                pwmout <= '0';  
            end if;
        end if; 
    end process pwm_p; 
    
    
    
    
    
    
    
    
    
--    counter_p : PROCESS(clk, reset)
--    BEGIN 
--        IF RISING_EDGE(clk) THEN
--            IF reset = '1' THEN 
--                pwmout <= '0'; 
--                counter <= (others => '0'); 
--            ELSE 
--                IF enable = '1' THEN 
--                    counter <= counter + 1; 
--                    IF (pval < counter) THEN 
--                        pwmout <= '0'; 
--                    ELSE 
--                        pwmout <= '1'; 
--                    END IF; 
--                ELSE 
--                    pwmout <= '0'; 
--                END IF; 
--            END IF; 
--        END IF;
--    END PROCESS counter_p; 
   

end Behavioral;
