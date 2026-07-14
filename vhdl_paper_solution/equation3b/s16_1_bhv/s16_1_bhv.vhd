-- this circuit is a 2-bit counter that counts up when u = '1' and pause the counting when s = '0'. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in behavioral style.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_1_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL cnt : unsigned(1 DOWNTO 0) := "00";

BEGIN

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '0' THEN
                cnt <= cnt;
            ELSE
                cnt <= cnt + 1;
            END IF;
        END IF;
    END PROCESS;

    -- output 
    x <= STD_LOGIC_VECTOR(cnt);

END ARCHITECTURE behavioral;