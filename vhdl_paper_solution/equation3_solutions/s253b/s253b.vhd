-- this circuit is a pattern detector, and detects how many times the pattern "010" appears in the input stream.
-- this is the structural implementation of the circuit.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s253b IS
    PORT (
        clk : IN STD_LOGIC;
        d_in : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s253b IS

    SIGNAL count : unsigned(1 DOWNTO 0) := "00";
    SIGNAL readbuf : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN

    seq_det_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN

            -- Check the sequence including the current input bit
            IF readbuf = "010" THEN
                count <= count + 1;
            END IF;

            -- Shift the current input into the buffer
            readbuf <= readbuf(1 DOWNTO 0) & d_in;

        END IF;
    END PROCESS seq_det_p;

    y <= STD_LOGIC_VECTOR(count);

END ARCHITECTURE behavioral;