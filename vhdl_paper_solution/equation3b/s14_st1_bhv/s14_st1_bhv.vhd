-- this circuit is the PRBS (pseudo random binary sequence generator)
-- if u = '0', then it will generate the prbs sequence 1, 8, 4, 2, 9, 12, 6, 11, 5, 10, 13, 14, 15, 7, 3, `. 
-- if u = '1', then it will shift the number '1' inside the shift register. 
-- this vhdl code shows the behavioral  implementation. 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st1_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st1_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";

BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
        VARIABLE a : STD_LOGIC;
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '1' THEN
                q <= '1' & q(3 DOWNTO 1);
            ELSE
                IF q(1) = q(0) THEN
                    q <= '0' & q(3 DOWNTO 1);
                ELSE
                    q <= '1' & q(3 DOWNTO 1);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    x <= q(0);
END ARCHITECTURE behavioral;