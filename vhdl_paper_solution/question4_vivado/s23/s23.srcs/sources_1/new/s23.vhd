----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/17/2026 12:01:47 AM
-- Design Name: 
-- Module Name: s23 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: UART serial tranmission protocol 
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

entity s23 is
    Port (
        clk : in std_logic; 
        start : in std_logic; 
        reset : in std_logic; 
        data_in : in std_logic_vector(7 downto 0); 
        y_out : out std_logic
     );
end s23;

architecture Behavioral of s23 is
    type state_type is (idle, state_0, state_trans, state_parity, state_stop); 
    signal state, next_state : state_type; 
    
    subtype counter_type is integer range 0 to 7; 
    signal cnt, cnt_i : counter_type; 
    signal write_buf : std_logic_vector(7 downto 0) := (others=>'0'); 
    signal read_buf : std_logic_vector(7 downto 0) := (others=>'0');
    
    signal y_out_i : std_logic := '0';  
    
    constant MAXBITS : integer := 8; 
begin
    
    -- sequential process 
    seq_p : process(clk)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= idle; 
                cnt <= 0; 
            else 
                if next_state = state_0 then 
                    write_buf <= data_in;
                end if; 
                
                if state = state_trans then 
                    read_buf <= y_out_i & read_buf(7 downto 1); 
                end if; 
                
                state <= next_state; 
                cnt <= cnt_i;  
            end if; 
        end if; 
    end process seq_p; 
    
    -- combinational process 
    comb_p : process(state, start, cnt)
    begin 
        -- default cases 
        next_state <= state; 
        cnt_i <= cnt; 
        y_out_i <= '1'; 
        
        case state is 
            when idle    => 
                y_out_i <= '1'; 
                if start = '1' then 
                    next_state <= state_0;                 
                end if; 
            when state_0      => 
                cnt_i <= 0; 
                y_out_i <= '0'; 
                next_state <= state_trans; 
            when state_trans  => 
                y_out_i <= write_buf(cnt); 
                --read_buf <= y_out_i & read_buf(7 downto 1); 
                if cnt = MAXBITS - 1 then 
                    next_state <= state_parity;
                else 
                    next_state <= state_trans; 
                    cnt_i <= cnt + 1; 
                end if; 
            when state_parity =>  
                y_out_i <= '1' XOR write_buf(MAXBITS -1) XOR write_buf(MAXBITS -2) XOR write_buf(MAXBITS -3) XOR write_buf(MAXBITS -4) XOR write_buf(MAXBITS -5) XOR write_buf(MAXBITS -6) XOR write_buf(MAXBITS -7) XOR write_buf(MAXBITS -8); 
                next_state <= state_stop; 
            when state_stop   =>
                -- stop bit   
                y_out_i <= '1'; 
                if start = '0' then 
                    next_state <= idle; 
                else 
                    next_state <= state_trans;
                end if; 
        end case; 
    end process comb_p; 
    
    y_out <= y_out_i; 


end Behavioral;










