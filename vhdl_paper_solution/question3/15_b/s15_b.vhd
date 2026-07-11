--s15_3 behavioral implementation 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_b IS
    PORT (
        clk : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s15_b IS
    SIGNAL cnt : UNSIGNED(1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL count_up : STD_LOGIC := '0';
BEGIN

    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF count_up = '1' THEN
                IF cnt = "11" THEN
                    count_up <= '0';
                ELSE
                    cnt <= cnt + 1;
                END IF;
            ELSE
                IF cnt = "00" THEN
                    count_up <= '1';
                ELSE
                    cnt <= cnt - 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    --output logic 
    x <= STD_LOGIC_VECTOR(cnt);
END ARCHITECTURE behavioral;