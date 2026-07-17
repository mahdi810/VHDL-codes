LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        incr : IN STD_LOGIC;
        stop : IN STD_LOGIC;
        clk_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s16 IS
    TYPE state_type IS (idle, state_1_L, state_1_H, state_10_L, state_10_H);
    SIGNAL state, next_state : state_type;
    SIGNAL timer : INTEGER := 0;

    CONSTANT c1Mhz_coeff : INTEGER := 49;
    CONSTANT c10Mhz_coeff : INTEGER := 4;
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
        VARIABLE cnt : INTEGER := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                cnt := 0;
            ELSE
                IF cnt = timer THEN
                    state <= next_state;
                    cnt := 0;
                ELSE
                    cnt := cnt + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, start, stop, incr)
    BEGIN
        -- default cases 
        next_state <= state;
        timer <= 0;
        clk_out <= '0';

        CASE state IS
            WHEN idle =>
                IF start = '1' THEN
                    next_state <= state_1_L;
                END IF;
            WHEN state_1_L =>
                timer <= c1Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSIF incr = '1' THEN
                    next_state <= state_10_L;
                ELSE
                    next_state <= state_1_H;
                END IF;
            WHEN state_1_H =>
                clk_out <= '1';
                timer <= c1Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSIF incr = '1' THEN
                    next_state <= state_10_L;
                ELSE
                    next_state <= state_1_L;
                END IF;
            WHEN state_10_L =>
                timer <= c10Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_10_H;
                END IF;
            WHEN state_10_H =>
                clk_out <= '1';
                timer <= c10Mhz_coeff;
                IF stop = '1' THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_10_L;
                END IF;
        END CASE;
    END PROCESS;

END ARCHITECTURE behavioral;