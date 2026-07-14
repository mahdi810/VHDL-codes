-- this circuit is a 2-bit counter that counts up when u = '1' and pause the counting when s = '0'. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in structural style.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1 IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_1 IS
    SIGNAL q : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL a, b, c, d, e, f, g : STD_LOGIC;

BEGIN

    -- combinational logic 
    a <= u OR q(1);
    b <= q(1) OR q(0);
    c <= (NOT u) OR (NOT q(0)) OR (NOT q(1));
    d <= a AND b AND c;

    e <= (NOT u) AND q(0);
    f <= (NOT q(0)) AND u;
    g <= e OR f;

    -- output logic 
    x <= q(1 DOWNTO 0);

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= g;
            q(1) <= d;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;