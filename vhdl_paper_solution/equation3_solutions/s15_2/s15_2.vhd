-- this circuit is a 2-bit up-down counter that counts up and down. The output x represents the current count value of the counter. and this circuit is implemented in vhdl in structural style.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2 IS
    PORT (
        clk : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s15_2 IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL a, b, c, d : STD_LOGIC;

BEGIN

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= NOT q(0);
            q(1) <= d;
            -- q(1) <= ((NOT q(2) AND q(1))) OR ((NOT q(2)) AND q(0)) OR (q(1) AND q(0));
            q(2) <= q(1);
        END IF;
    END PROCESS;

    -- combinational logic 
    a <= ((NOT q(2) AND q(1)));
    b <= ((NOT q(2)) AND q(0));
    c <= (q(1) AND q(0));
    d <= a OR b OR c;

    -- output logic 
    x <= q(1 DOWNTO 0);

END ARCHITECTURE behavioral;