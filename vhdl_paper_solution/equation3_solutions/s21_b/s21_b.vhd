-- this circuit is a 5-bit shift register with a feedback loop that generates a specific output based on the input signal 'u' and the current state of the register. The output 'y' is determined by the logic conditions defined in the architecture.
-- the output becomes when the register sequence reaches "00101"
-- this is the behavioral implementation of the circuit.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s21_b IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF s21_b IS
    SIGNAL q : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
BEGIN

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            -- making the shift register 
            q <= u & q(4 DOWNTO 1);
            IF q = "10100" THEN
                y <= '1';
            ELSE
                y <= '0';
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE behavioral;