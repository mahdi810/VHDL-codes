LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s25_tb IS
    COMPONENT s25 IS
        PORT (
            clk : IN STD_LOGIC;
            mod_d : IN STD_LOGIC;
            start : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT s25;
    SIGNAL mod_d, start : STD_LOGIC;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL y : STD_LOGIC_VECTOR(2 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : s25
    PORT MAP(
        clk => clk,
        mod_d => mod_d,
        start => start,
        y => y
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        start <= '0';
        mod_d <= '0';
        WAIT FOR clk_period;

        start <= '0';
        mod_d <= '1';
        WAIT FOR clk_period;

        start <= '1';
        mod_d <= '0';
        WAIT FOR clk_period * 10;

        start <= '0';
        WAIT FOR clk_period * 5;

        start <= '1';
        mod_d <= '1';
        WAIT FOR clk_period * 10;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;