LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24_3b IS
    PORT (
        clk : IN STD_LOGIC;
        d_in : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s24_3b IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN

    -- s_reg process 
    s_reg_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF sel = '1' THEN
                q <= q(3 DOWNTO 0) & d_in;
            ELSE
                IF d_in = '0' THEN
                    q <= q(2 DOWNTO 0) & "00";
                ELSE
                    q <= q(2 DOWNTO 0) & "11";
                END IF;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;