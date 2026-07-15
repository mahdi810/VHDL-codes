-- this circuit is used to calculate the complement of a 3-bit number. The circuit has a control input u, which determines whether the output y is equal to the input x (when u=1) or the complement of the input x (when u=0). The circuit uses flip-flops to store the state of the output y, and combinational logic to calculate the next state based on the current state and the input x.
--s23_3b behavioral implementation 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3b IS
    PORT (
        clk : IN STD_LOGIC;
        u : IN STD_LOGIC;
        x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF s23_3b IS
    SIGNAL q : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL x_in : INTEGER := 0;
BEGIN

    x_in <= to_integer(signed(x));

    -- sequential process 
    seq_p : PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF u = '1' THEN
                q <= STD_LOGIC_VECTOR(to_signed(x_in, q'length));
            ELSE
                --complement logic
                q <= STD_LOGIC_VECTOR(to_signed(-x_in, q'length));
            END IF;
        END IF;
    END PROCESS;

    --combinational process 
    y <= q;

END ARCHITECTURE behavioral;