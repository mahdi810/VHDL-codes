LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s22_b_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s22_b_tb IS
    COMPONENT s22_b IS
        PORT (
            clk : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT s22_b;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL y : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : s22_b
    PORT MAP(
        clk => clk,
        y => y
    );
    --stimulus process
    stim_p : PROCESS
    BEGIN
        WAIT FOR clk_period;

        WAIT;
    END PROCESS;
END ARCHITECTURE behavioral;