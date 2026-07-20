LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s20 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        u : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        yout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY s20;

ARCHITECTURE behavioral OF s20 IS
    TYPE state_type IS (idle, state_init, state_1, state_2, state_check);
    SIGNAL state, next_state : state_type;

    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 8;

    SIGNAL yk, yk1, xk, xk1, zk, zk1 : int16_t;
    SIGNAL counter, counter_i : counter_type;

BEGIN
    -- sequential process
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                counter <= 0;
                xk <= 0;
                yk <= 0;
                zk <= 0;
            ELSE
                state <= next_state;
                counter <= counter_i;
                xk <= xk1;
                yk <= yk1;
                zk <= zk1;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- combinational process
    comb_p : PROCESS (state, start, counter, xk, yk, zk, u)
    BEGIN
        --default cases
        next_state <= state;
        counter_i <= counter;
        xk1 <= xk;
        yk1 <= yk;
        zk1 <= zk;
        done <= '0';

        CASE state IS
            WHEN idle =>
                done <= '1';
                IF start = '1' THEN
                    next_state <= state_init;
                END IF;
            WHEN state_init =>
                counter_i <= 0;
                yk1 <= (2 ** 14) + (to_integer(signed(u))/2);
                xk1 <= (2 ** 14) - (to_integer(signed(u))/2);
                zk1 <= 0;
                next_state <= state_check;
            WHEN state_check =>
                IF counter = 8 THEN
                    next_state <= idle;
                ELSE
                    IF yk < 0 THEN
                        next_state <= state_1;
                    ELSE
                        next_state <= state_2;
                    END IF;
                END IF;
            WHEN state_1 =>
                yk1 <= yk + (xk/(2 ** counter));
                zk1 <= zk - ((2 ** 14)/(2 ** counter));
                IF counter < 8 THEN
                    counter_i <= counter + 1;
                END IF;
                next_state <= state_check;
            WHEN state_2 =>
                yk1 <= yk - (xk/(2 ** counter));
                zk1 <= zk + ((2 ** 14)/(2 ** counter));
                IF counter < 8 THEN
                    counter_i <= counter + 1;
                END IF;
                next_state <= state_check;
        END CASE;
    END PROCESS comb_p;

    -- output
    yout <= STD_LOGIC_VECTOR(to_signed(zk, yout'length));

END ARCHITECTURE behavioral;