-- this circuit is a 5-bit shift register with a feedback loop that generates a specific output based on the input signal 'u' and the current state of the register. The output 'y' is determined by the logic conditions defined in the architecture.
-- the output becomes when the register sequence reaches "00101"
-- this is the structural implementation of the circuit.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s21_3a IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s21_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
    SIGNAL a, b, c, d, e, f, g : STD_LOGIC := '0';
BEGIN

    -- combinational circuits 
    a <= u AND g;
    b <= q(4) AND g;
    c <= q(3) AND g;
    d <= q(2) AND g;
    e <= q(1) AND g;
    f <= q(4) AND (NOT q(3)) AND q(2) AND (NOT q(1)) AND (NOT q(0));
    g <= NOT f;

    -- output logic 
    y <= f;

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(4) <= a;
            q(3) <= b;
            q(2) <= c;
            q(1) <= d;
            q(0) <= e;
        END IF;
    END PROCESS;
END ARCHITECTURE behavioral;