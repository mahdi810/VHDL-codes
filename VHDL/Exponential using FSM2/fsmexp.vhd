----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mohammad Mahdi Mohammadi
-- 
-- Create Date: 10/12/2025 11:59:59 PM
-- Design Name: 
-- Module Name: fsmexp - Behavioral
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


--this program computes the exponential function y = exp(u) using the itertive methode. 
--if y0 < 0 then 
    --y <= y0 - 2^(-k)*x0 
    --z <= z0 - 2^(-k)
--else 
    --y <= y0 + 2^(-k)*x0 
    --z <= z0 + 2^(-k)
--end if; 
--the above equations shows the basic algorithm for the computation of the exponential function. 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsmexp is
    generic (it_no : integer := 10);
    port (clk   : in std_logic;
          start : in std_logic;
          done  : out std_logic;
          reset : in std_logic;
          u_in  : in std_logic_vector(15 downto 0);
          u_out : out std_logic_vector(15 downto 0) );
end entity;

architecture bhv of fsmexp is
    type state_type is (idle, init, it1, it2, final);
    signal state, next_state : state_type;
    
    signal k_i, k_i_next : integer := 0; 
    subtype int16_t is integer range -32768 to 32767; 
    constant fract : integer := 13; 
    
    signal u_in_i : int16_t:= 0;
    signal x0, x0_next : int16_t:= 0;
    signal y0, y0_next : int16_t:= 0;
    signal z0, z0_next : int16_t:= 0;

begin
    u_in_i <= to_integer(unsigned(u_in)); 

    --the sequential process
    seq_p : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= idle;
                k_i   <= 0;
                x0  <= 0;
                y0  <= 0;
                z0  <= 0;
            else
                state <= next_state;
                x0 <= x0_next; 
                y0 <= y0_next; 
                z0 <= z0_next; 
                k_i <= k_i_next; 
            end if; 
        end if; 
    end process seq_p;

    --combinatin process
    comb_p : process(state, start, next_state, x0_next, y0_next, z0_next, k_i)
    begin 
        done <= '0';
        x0_next <= x0;
        y0_next <= y0;
        z0_next <= z0;
        next_state <= state;
        k_i_next <= k_i;
        case state is 
            when idle   => 
                done <= '1'; 
                if start = '1' then 
                    next_state <= init; 
                else 
                    next_state <= idle; 
                end if; 
            when init   =>
                k_i_next <= 0; 
                x0_next <= (2**fract)-(u_in_i/2);
                y0_next <= (2**fract)+(u_in_i/2);
                z0_next <= 0; 
                if y0_next > 0 then 
                    next_state <= it2; 
                else 
                    next_state <= it1; 
                end if; 
            when it1    =>
                k_i_next <= k_i + 1;  
                y0_next <= y0 + (x0/2**k_i);
                z0_next <= z0 - (2**fract/2**(k_i));
                if k_i_next = it_no then 
                    next_state <= final; 
                elsif y0_next > 0 then 
                    next_state <= it2; 
                else 
                    next_state <= it1; 
                end if;  
            when it2    =>
                k_i_next <= k_i + 1; 
                y0_next <= y0 - (x0/(2**(k_i)));
                z0_next <= z0 + (2**fract/2**(k_i));
                if k_i_next = it_no then 
                    next_state <= final;
                elsif y0_next < 0 then 
                    next_state <= it1;
                else 
                    next_state <= it2; 
                end if; 
            when final  => 
                u_out <= std_logic_vector(to_signed(z0_next, u_out'length)); 
                next_state <= idle; 
        end case; 
    end process comb_p; 
end bhv;
