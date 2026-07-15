-- this circuit is a bidirectional shift register with 4 bits. The input s controls the direction of the shift. When s = '0', the register shifts to the right, and when s = '1', it shifts to the left. The outputs x and y represent the second and first bits of the register, respectively.
--this circuit is implemented in vhdl in behavioral style. 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_2_bhv IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x : OUT STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_2_bhv IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"1";
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF s = '0' THEN
                q <= q(0) & q(3 DOWNTO 1);
            ELSE
                q <= q(2 DOWNTO 0) & q(3);
            END IF;
        END IF;
    END PROCESS;

    -- output 
    x <= q(1);
    y <= q(0);

END ARCHITECTURE behavioral;