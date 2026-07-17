LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        txdata : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
        TxD : OUT STD_LOGIC;
        done : OUT STD_LOGIC
    );
END ENTITY s16_1;

ARCHITECTURE behavioral OF s16_1 IS
    TYPE state_type IS (idle, state0, state_trans, state_parity, state_stopbit);
    SIGNAL state, next_state : state_type;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 6;
    SIGNAL cnt, cnt_i : counter_type;

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                cnt <= 0;
            ELSE
                state <= next_state;
                cnt <= cnt_i;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, start, cnt)
    BEGIN
        -- default cases 
        done <= '0';
        next_state <= state;
        TxD <= '0';

        CASE state IS
            WHEN idle =>
                TxD <= '1';
                done <= '1';
                IF start = '1' THEN
                    next_state <= state0;
                END IF;
            WHEN state0 =>
                cnt_i <= 6;
                next_state <= state_trans;
            WHEN state_trans =>
                TxD <= txdata(cnt);
                IF cnt = 0 THEN
                    next_state <= state_parity;
                ELSE
                    cnt_i <= cnt - 1;
                END IF;
            WHEN state_parity =>
                TxD <= txdata(0) XOR txdata(1) XOR txdata(1) XOR txdata(2) XOR txdata(3) XOR txdata(4) XOR txdata(5) XOR txdata(6);
                next_state <= state_stopbit;
            WHEN state_stopbit =>
                TxD <= '1';
                next_state <= idle;
        END CASE;
    END PROCESS;

END ARCHITECTURE behavioral;