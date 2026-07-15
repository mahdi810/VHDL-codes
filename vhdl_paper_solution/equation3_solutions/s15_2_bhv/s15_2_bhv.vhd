-- this circuit is a 2-bit up-down counter that counts up and down. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in behavioral style.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s15_2_bhv IS
    SIGNAL count : unsigned(1 DOWNTO 0) := "00";
    SIGNAL cnt_up : STD_LOGIC := '1';

BEGIN

    -- flipflops 
    up_down_count : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF cnt_up = '1' THEN
                IF count = "11" THEN
                    count <= count + 1;
                    cnt_up <= '0';
                ELSE
                    count <= count + 1;
                END IF;
            ELSE
                IF count = "00" THEN
                    count <= count - 1;
                    cnt_up <= '1';
                ELSE
                    count <= count - 1;
                END IF;
            END IF;
        END IF;
    END PROCESS up_down_count;
    -- output logic 
    x <= STD_LOGIC_VECTOR(count);

END ARCHITECTURE behavioral;