LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s15_2_tb IS
    COMPONENT s15_2 IS
        PORT (
            clk : IN STD_LOGIC;
            x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT s15_2;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL x : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clk generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s15_2
    PORT MAP(
        clk => clk,
        x => x
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        WAIT FOR clk_period * 6;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;