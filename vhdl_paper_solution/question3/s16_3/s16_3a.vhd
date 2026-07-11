LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_3a IS
    PORT (
        clk : IN STD_LOGIC;
        s : IN STD_LOGIC;
        x, y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s16_3a IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
    SIGNAL a, b, c, d : STD_LOGIC := '0';

    SIGNAL y_in : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(3) <= a;
            q(2) <= b;
            q(1) <= c;
            q(0) <= d;
        END IF;
    END PROCESS;

    -- combinational logic 
    a <= ((NOT s) AND q(0)) OR (s AND q(2));
    b <= ((NOT s) AND q(3)) OR (s AND q(1));
    c <= ((NOT s) AND q(2)) OR (s AND q(0));
    d <= ((NOT s) AND q(1)) OR (s AND q(3));

    --outputs 
    x <= q(1);
    y <= q(0);

    y_in <= q(1) & q(0);

END ARCHITECTURE behavioral;