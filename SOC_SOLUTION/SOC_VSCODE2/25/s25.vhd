LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        x_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY s25;

ARCHITECTURE behavioral OF s25 IS
    TYPE state_type IS (idle, init, state_cube0, state_cube1, state_cube2, state_root0, state_root1);
    SIGNAL state, next_state : state_type;

    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 25;

    CONSTANT input_frac : INTEGER := 11;
    CONSTANT output_frac : INTEGER := 13;
    CONSTANT iteration : INTEGER := 25;
    CONSTANT k0 : INTEGER := 1639; -- 0.05 in (int16_15)

    SIGNAL yk, yk1 : int16_t;
    SIGNAL temp, temp_i : int32_t;

    SIGNAL counter, counter_i : counter_type;
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                yk <= 0;
                temp <= 0;
                counter <= 0;
            ELSE
                state <= next_state;
                yk <= yk1;
                counter <= counter_i;
                temp <= temp_i;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process
    comb_p : PROCESS (state, counter, start, yk, temp, x_in)
    BEGIN
        --default cases 
        next_state <= state;
        done <= '0';
        yk1 <= yk;
        counter_i <= counter;
        temp_i <= temp;

        CASE state IS
            WHEN idle =>
                done <= '1';
                IF start = '1' THEN
                    next_state <= init;
                END IF;
            WHEN init =>
                yk1 <= 0;
                counter_i <= 0;
                temp_i <= 0;
                next_state <= state_cube0;
            WHEN state_cube0 =>
                temp_i <= yk * yk;
                next_state <= state_cube1;
            WHEN state_cube1 =>
                temp_i <= (temp / (2 ** 13)) * yk;
                next_state <= state_cube2;
            WHEN state_cube2 =>
                temp_i <= temp / (2 ** 15);
                next_state <= state_root0;
            WHEN state_root0 =>
                temp_i <= (to_integer(signed(x_in)) - temp) * k0;
                next_state <= state_root1;
            WHEN state_root1 =>
                yk1 <= yk + temp/(2 ** 13);
                IF counter < iteration THEN
                    counter_i <= counter + 1;
                END IF;

                IF counter = iteration THEN
                    next_state <= idle;
                ELSE
                    next_state <= state_cube0;
                END IF;
        END CASE;
    END PROCESS;

    y <= STD_LOGIC_VECTOR(to_signed(yk, y'length));

END ARCHITECTURE behavioral;