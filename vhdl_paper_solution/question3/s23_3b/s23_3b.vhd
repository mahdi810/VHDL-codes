--s23_3b behavioral implementation 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3b IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s23_3b IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '1' THEN
                q <= x;
            ELSE
                q(0) <= q(0);
                q(1) <= q(1) XOR q(0);
                q(2) <= q(2) XOR (q(1) OR q(0));
            END IF;
        END IF;
    END PROCESS;

    --combinational process 
    y <= q;

END ARCHITECTURE behavioral;