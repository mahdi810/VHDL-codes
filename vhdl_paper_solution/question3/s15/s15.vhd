--s15_3 structural implementation 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15 IS
    PORT (
        clk : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s15 IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL a : STD_LOGIC;
BEGIN

    --flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= NOT q(0);
            q(1) <= a;
            q(2) <= q(1);
        END IF;
    END PROCESS;

    -- combinational logic implementation 
    a <= ((NOT q(2)) AND q(1)) OR ((NOT q(1)) AND q(0)) OR (q(1) AND q(0));

    -- output logic implementation 
    x <= q(1 DOWNTO 0);

END ARCHITECTURE behavioral;