LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24 IS
    PORT (
        clk : IN STD_LOGIC;9
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        xin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        yout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY s24;

ARCHITECTURE behavioral OF s24 IS
    TYPE state_type IS (idle, init, state1, state2, state3, state4, state5);
    SIGNAL state, next_state : state_type;
    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;
    SUBTYPE counter_type IS INTEGER RANGE 0 TO 15;

    CONSTANT rightv_init : int16_t := 4096; -- 4 in int16_10 
    CONSTANT leftv_init : int16_t := 1024; -- 1 in int16_10 

    SIGNAL counter, counter_i : counter_type;
    SIGNAL temp, temp_i : int32_t;
    SIGNAL newx : int16_t := 0;
    SIGNAL leftv, leftv_i, rightv, rightv_i : int16_t;

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                counter <= 0;
                temp <= 0;
                rightv <= 0;
                leftv <= 0;
            ELSE
                state <= next_state;
                counter <= counter_i;
                temp <= temp_i;
                leftv <= leftv_i;
                rightv <= rightv_i;
            END IF;
        END IF;
    END PROCESS seq_p;

    -- combinational process 
    comb_p : PROCESS (state, start, counter)
    BEGIN
        -- default cases 
        done <= '0';
        next_state <= state;
        counter_i <= counter;
        temp_i <= temp;
        leftv_i <= leftv;
        rightv_i <= rightv;

        CASE state IS
            WHEN idle =>
                done <= '1';
                IF start = '1' THEN
                    next_state <= init;
                END IF;
            WHEN init =>
                rightv_i <= rightv_init;
                leftv_i <= leftv_init;
                counter_i <= 0;
                newx <= 0;
                next_state <= state1;
            WHEN state1 =>
                newx <= (leftv + rightv)/2;
                next_state <= state2;
            WHEN state2 =>
                temp_i <= (newx * newx);
                next_state <= state3;
            WHEN state3 =>
                temp_i <= (temp - to_integer(signed(xin)));
                next_state <= state4;
            WHEN state4 =>
                temp_i <= temp / (2 ** 13);
                IF counter <= 15 THEN
                    counter_i <= counter + 1;
                END IF;
                next_state <= state5;
            WHEN state5 =>
                IF temp >= 0 THEN
                    rightv_i <= newx;
                ELSE
                    leftv_i <= newx;
                END IF;
                IF counter = 15 THEN
                    next_state <= idle;
                ELSE
                    next_state <= state1;
                END IF;
        END CASE;
    END PROCESS comb_p;

    yout <= STD_LOGIC_VECTOR(to_signed(newx, yout'length));

END ARCHITECTURE behavioral;