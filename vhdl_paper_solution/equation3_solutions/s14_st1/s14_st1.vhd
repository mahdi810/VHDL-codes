-- this circuit is the PRBS (pseudo random binary sequence generator)
-- if u = '0', then it will generate the prbs sequence 1, 8, 4, 2, 9, 12, 6, 11, 5, 10, 13, 14, 15, 7, 3. 
-- if u = '1', then it will shift the number '1' inside the shift register. 
-- this vhdl code shows the structural implementation. 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st1 IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s14_st1 IS
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
    SIGNAL a : STD_LOGIC;
BEGIN
    -- flipflops 
    ff : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            q(0) <= q(1);
            q(1) <= q(2);
            q(2) <= q(3);
            q(3) <= a;
        END IF;
    END PROCESS;

    a <= u OR (q(1) XOR q(0));
    x <= q(0);

END ARCHITECTURE behavioral;