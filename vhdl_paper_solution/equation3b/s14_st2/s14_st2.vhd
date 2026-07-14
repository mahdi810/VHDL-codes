-- this circuit is a 2-bit up-down counter that counts up and down. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in structural style.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st2 IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st2 IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    SIGNAL a, b, c, d, e, f : STD_LOGIC;

BEGIN
    -- combinational logic 
    a <= q(3) AND (NOT q(2));
    b <= a XOR q(0);
    c <= (NOT a) AND q(1);
    d <= q(1) AND (NOT q(0));
    e <= a AND (NOT q(1)) AND q(0);
    f <= c OR d OR e;

    -- outputs 
    x(0) <= q(0);
    x(1) <= q(1);

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= b;
            q(1) <= f;
            q(2) <= q(3);
            q(3) <= s;
        END IF;
    END PROCESS;
END ARCHITECTURE behavioral;