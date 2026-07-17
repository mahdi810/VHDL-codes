LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2 IS
    GENERIC (
        NBITS : INTEGER := 12
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        pval : IN STD_LOGIC_VECTOR(NBITS - 1 DOWNTO 0);
        pwmout : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s15_2 IS
    SIGNAL counter : unsigned(NBITS - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN

    -- free running counter 
    cnt_p : PROCESS (clk, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                counter <= (OTHERS => '0');
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS cnt_p;

    -- PWM process 
    pwm_p : PROCESS (clk, enable, pval, counter, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                pwmout <= '0';
            ELSIF enable = '0' THEN
                pwmout <= '0';
            ELSIF counter > unsigned(pval) THEN
                pwmout <= '0';
            ELSE
                pwmout <= '1';
            END IF;
        END IF;
    END PROCESS pwm_p;

END ARCHITECTURE behavioral;