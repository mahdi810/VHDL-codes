LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s21_3a_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s21_3a_tb IS
    COMPONENT s21_3a IS
        PORT (
            clk : IN STD_LOGIC;
            u : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT s21_3a;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL u, y : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s21_3a
    PORT MAP(
        clk => clk,
        u => u,
        y => y
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        u <= '0';
        WAIT FOR clk_period;
        u <= '0';
        WAIT FOR clk_period;
        u <= '1';
        WAIT FOR clk_period;
        u <= '0';
        WAIT FOR clk_period;
        u <= '1';
        WAIT FOR clk_period;
        WAIT;
    END PROCESS;
END ARCHITECTURE behavioral;