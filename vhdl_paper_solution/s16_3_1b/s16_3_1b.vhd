LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_3_1b IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_3_1b IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
    -- SUBTYPE counter_type IS INTEGER RANGE 0 TO 3;
    SIGNAL count : UNSIGNED(1 DOWNTO 0) := "00";
BEGIN

    count_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '1' THEN
                count <= count + 1;
            ELSE
                count <= count;
            END IF;
        END IF;
    END PROCESS;

    -- output 
    x <= STD_LOGIC_VECTOR(count);

END ARCHITECTURE behavioral;