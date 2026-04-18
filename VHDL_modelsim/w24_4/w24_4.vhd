LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY w24_4 IS
    PORT (
        clk, reset, start : IN STD_LOGIC;
        y_out : OUT STD_LOGIC
    );
END w24_4;

ARCHITECTURE behavioral OF w24_4 IS
    TYPE state_type IS (idle, st16, st16b, st14, st14b, st12, st12b, st10, st10b, st8, st8b, st4, st4b, st2, st2b);
    SIGNAL state, next_state : state_type;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 15;
    SIGNAL timer : counter_type := 0;
BEGIN

    --sequential process
    PROCESS (clk, reset)
        VARIABLE cnt : counter_type := 0;
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
    --combinational process
    comb_p : PROCESS (state, start, timer)
    BEGIN
        --default values 
        next_state <= state;
        y_out <= '0';

        CASE state IS
            WHEN idle =>
                IF start = '1' THEN
                    next_state <= st16;
                END IF;
            WHEN st16 =>
                y_out <= '1';
                timer <= 7;
                IF start = '1' THEN
                    next_state <= st16b;
                END IF;
            WHEN st16b =>
                timer <= 7;
                IF start = '1' THEN
                    next_state <= st14;
                END IF;
            WHEN st14 =>
                y_out <= '1';
                timer <= 6;
                IF start = '1' THEN
                    next_state <= st14b;
                END IF;
            WHEN st14b =>
                timer <= 6;
                IF start = '1' THEN
                    next_state <= st12;
                END IF;
            WHEN st12 =>
                y_out <= '1';
                timer <= 5; 
                IF start = '1' THEN
                    next_state <= st12b;
                END IF;
            WHEN st12b =>
                timer <= 5; 
                IF start = '1' THEN
                    next_state <= st10;
                END IF;
            WHEN st10 =>
                y_out <= '1';
                timer <= 4; 
                IF start = '1' THEN
                    next_state <= st10b;
                END IF;
            WHEN st10b =>
                timer <= 4; 
                IF start = '1' THEN
                    next_state <= st8;
                END IF;
            WHEN st8 =>
                y_out <= '1';
                timer <= 3; 
                IF start = '1' THEN
                    next_state <= st8b;
                END IF;
            WHEN st8b =>
                timer <= 3; 
                IF start = '1' THEN
                    next_state <= st4;
                END IF;
            WHEN st4 =>
                y_out <= '1';
                timer <= 1; 
                IF start = '1' THEN
                    next_state <= st4b;
                END IF;
            WHEN st4b =>
                timer <= 1; 
                IF start = '1' THEN
                    next_state <= st2;
                END IF;
            WHEN st2 =>
                y_out <= '1';
                timer <= 0; 
                IF start = '1' THEN
                    next_state <= st2b;
                END IF;
            WHEN st2b =>
                timer <= 0; 
                IF start = '1' THEN
                    next_state <= st16;
                ELSE
                    next_state <= idle;
                END IF;
        END CASE;
    END PROCESS;

END behavioral; -- behavioral