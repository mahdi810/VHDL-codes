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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY s23 IS
    PORT (
        clk : IN STD_LOGIC;
        start : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        y_out : OUT STD_LOGIC
    );
END s23;

ARCHITECTURE Behavioral OF s23 IS
    TYPE state_type IS (idle, state_0, state_trans, state_parity, state_stop);
    SIGNAL state, next_state : state_type;

    SUBTYPE counter_type IS INTEGER RANGE 0 TO 7;
    SIGNAL cnt, cnt_i : counter_type;
    SIGNAL write_buf : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL read_buf : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

    SIGNAL y_out_i : STD_LOGIC := '0';

    CONSTANT MAXBITS : INTEGER := 8;
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                cnt <= 0;
            ELSE
                IF next_state = state_0 THEN
                    write_buf <= data_in;
                END IF;

                IF state = state_trans THEN
                    read_buf <= y_out_i & read_buf(7 DOWNTO 1);
                END IF;

                state <= next_state;
                cnt <= cnt_i;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- combinational process 
    comb_p : PROCESS (state, start, cnt)
    BEGIN
        -- default cases 
        next_state <= state;
        cnt_i <= cnt;
        y_out_i <= '1';

        CASE state IS
            WHEN idle =>
                y_out_i <= '1';
                IF start = '1' THEN
                    next_state <= state_0;
                END IF;
            WHEN state_0 =>
                cnt_i <= 0;
                y_out_i <= '0';
                next_state <= state_trans;
            WHEN state_trans =>
                y_out_i <= write_buf(cnt);
                --read_buf <= y_out_i & read_buf(7 downto 1); 
                IF cnt = MAXBITS - 1 THEN
                    next_state <= state_parity;
                ELSE
                    next_state <= state_trans;
                    cnt_i <= cnt + 1;
                END IF;
            WHEN state_parity =>
                y_out_i <= '1' XOR write_buf(MAXBITS - 1) XOR write_buf(MAXBITS - 2) XOR write_buf(MAXBITS - 3) XOR write_buf(MAXBITS - 4) XOR write_buf(MAXBITS - 5) XOR write_buf(MAXBITS - 6) XOR write_buf(MAXBITS - 7) XOR write_buf(MAXBITS - 8);
                next_state <= state_stop;
            WHEN state_stop =>
                -- stop bit   
                y_out_i <= '1';
                IF start = '0' THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_trans;
                END IF;
        END CASE;
    END PROCESS comb_p;

    y_out <= y_out_i;
END Behavioral;