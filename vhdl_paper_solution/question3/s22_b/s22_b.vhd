LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22_b IS
    PORT (
        clk : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s22_b IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1101";
    SIGNAL yin : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            -- the data shift inside the register 
            q <= q(0) & q(3 DOWNTO 1);
            IF q = "1110" THEN
                yin <= (OTHERS => '0');
            ELSE
                yin <= q;
            END IF;
        END IF;
    END PROCESS;

    y <= yin;

END ARCHITECTURE behavioral;