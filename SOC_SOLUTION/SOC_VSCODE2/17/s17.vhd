LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s17 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        iter : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        fout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY s17;

ARCHITECTURE behavioral OF s17 IS
    TYPE state_type IS (idle, state_init, state_fib1, state_check);
    SIGNAL state, next_state : state_type;
    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 63;

    SIGNAL f0, f0n, f1, f1n : int16_t;
    SIGNAL counter, counter_i : counter_type;

BEGIN
    --sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                counter <= 0;
                f0 <= 0;
                f1 <= 0;
            ELSE
                state <= next_state;
                counter <= counter_i;
                f0 <= f0n;
                f1 <= f1n;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, start, counter, f1, f0, iter)
    BEGIN
        -- default cases 
        done <= '0';
        next_state <= state;
        counter_i <= counter;
        f0n <= f0;
        f1n <= f1;

        CASE state IS
            WHEN idle =>
                done <= '1';
                IF start = '1' THEN
                    next_state <= state_init;
                END IF;
            WHEN state_init =>
                f0n <= 0;
                f1n <= 1;
                counter_i <= 1;
                next_state <= state_fib1;
            WHEN state_fib1 =>
                f0n <= f1;
                f1n <= f0 + f1;
                IF counter < to_integer(signed(iter)) THEN
                    counter_i <= counter + 1;
                END IF;
                next_state <= state_check;
            WHEN state_check =>
                IF counter = TO_INTEGER(signed(iter)) THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_fib1;
                END IF;
        END CASE;
    END PROCESS;

    -- output 
    fout <= STD_LOGIC_VECTOR(to_signed(f1, fout'length));
END ARCHITECTURE behavioral;