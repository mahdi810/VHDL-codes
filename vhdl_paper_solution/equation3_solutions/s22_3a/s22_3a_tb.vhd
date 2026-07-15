-- this circuit is a 4-bit shift register that will become "0000", when the data inside the register becomes "1110", then the output will become "0000". 
-- this is the structural implementation of the circuit.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22_3a_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s22_3a_tb IS
    COMPONENT s22_3a IS
        PORT (
            clk : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT s22_3a;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL y : STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clcok generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s22_3a
    PORT MAP(
        clk => clk,
        y => y
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        WAIT FOR clk_period * 10;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;