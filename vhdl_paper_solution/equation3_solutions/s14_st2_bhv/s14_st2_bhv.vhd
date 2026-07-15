-- this circuit is used to count the rising edges of the input signal s. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in behavioral style.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st2_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st2_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL s_prev : STD_LOGIC := '0';
    SIGNAL count : unsigned(1 DOWNTO 0) := "00";

BEGIN

    -- flipflops 
    ff : PROCESS (clk, s)
    BEGIN
        IF rising_edge(clk) THEN
            IF (s = '1') AND (s_prev = '0') THEN
                count <= count + 1;
            END IF;
            s_prev <= s;
        END IF;
    END PROCESS;

    x <= STD_LOGIC_VECTOR(count);
END ARCHITECTURE behavioral;