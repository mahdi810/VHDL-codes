LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25 IS
    GENERIC (
        DATA_NBITS : INTEGER := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        meas_on : IN STD_LOGIC;
        d_in : IN STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0);
        sign_cnt : OUT STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0)
    );
END s25;

ARCHITECTURE behavioral OF s25 IS
    TYPE state_type IS (idle, init, sample);
    SIGNAL state, next_state : state_type;

    SUBTYPE int16_t IS INTEGER RANGE -32768 TO 32767;
    SUBTYPE int32_t IS INTEGER RANGE -2147483648 TO 2147483647;

    SIGNAL sign_cnt_i : int16_t := 0;
    SIGNAL sign_cnt_ii : int16_t := 0;
    SIGNAL prev_val, prev_val_i, current_val, current_val_i : signed(DATA_NBITS - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
                sign_cnt_i <= 0;
                prev_val <= (OTHERS => '0');
                current_val <= (OTHERS => '0');
            ELSE
                state <= next_state;
                sign_cnt_i <= sign_cnt_ii;
                prev_val <= prev_val_i;
                current_val <= current_val_i;
            END IF;
        END IF;
    END PROCESS;

    -- combinational process 
    comb_p : PROCESS (state, meas_on, prev_val, current_val)
    BEGIN
        -- default cases 
        next_state <= state;
        sign_cnt_ii <= sign_cnt_i;
        prev_val_i <= prev_val;
        current_val_i <= current_val;

        CASE state IS
            WHEN idle =>
                IF meas_on = '1' THEN
                    next_state <= init;
                END IF;
            WHEN init =>
                prev_val_i <= signed(d_in);
                next_state <= sample;
            WHEN sample =>
                IF prev_val_i(DATA_NBITS - 1) /= d_in(DATA_NBITS - 1) THEN
                    sign_cnt_ii <= sign_cnt_ii + 1;
                END IF;
                IF meas_on = '0' THEN
                    next_state <= idle;
                ELSE
                    next_state <= sample;
                END IF;
                prev_val_i <= signed(d_in);
        END CASE;
    END PROCESS;

    -- outputs 
    sign_cnt <= STD_LOGIC_VECTOR(to_signed(sign_cnt_ii, sign_cnt'length));

END ARCHITECTURE behavioral;