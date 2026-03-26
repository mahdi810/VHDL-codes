----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2026 01:02:46 PM
-- Design Name: 
-- Module Name: fibs - Behavioral
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

entity fibs is
    port(
        clk : in std_logic; 
        reset : in std_logic; 
        start : in std_logic; 
        done : out std_logic; 
        n : in unsigned(7 downto 0); 
        y_out : out unsigned(7 downto 0)
    ); 
end fibs; 

architecture behavioral of fibs is 
subtype int16_t is integer range -32768 to 32767;
signal f0, f1 : int16_t := 0;
signal count : int16_t := 0;
signal result : int16_t := 0;
type state_type is (idle, sstartx, run); 
signal state : state_type := idle; 

begin 

    --changint the input n to count;
    count <= to_integer(n); 

    --the main process to calculate the fibunacci series;
    fib_p : process(clk, reset, start, state)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then
                state <=  idle; 
                f0 <=  0; 
                f1 <=  0; 
                result <= 0; 
                done <= '0';
            else 
                case state is 
                    when idle => 
                        done <=  '1'; 
                        if start = '1' then 
                            state <= sstartx; 
                        end if; 
                    when sstartx =>  
                        --initialization of the first two numbers in the fibunacci series;
                        f0 <= 0;
                        f1 <= 1;
                        result <= 0; 
                        count <= count - 2; 
                        state <=  run; 
                    when run =>  
                        result <=  f0 + f1; 
                        f0 <=  f1; 
                        f1 <=  result;    
                        count <= count - 1;                   
                        if count = 0 then 
                            state <=  idle; 
                        end if; 
                end case; 
            end if; 
        end if; 
    end process fib_p; 


end behavioral; 
