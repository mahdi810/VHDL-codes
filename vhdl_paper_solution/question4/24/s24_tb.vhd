LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s24_tb IS
    COMPONENT s24 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            y_out : OUT STD_LOGIC
        );
    END COMPONENT s24;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL start : STD_LOGIC;
    SIGNAL y_out : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s24
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        y_out => y_out
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        start <= '0';
        reset <= '1';
        WAIT FOR clk_period * 4;

        reset <= '0';
        WAIT FOR clk_period * 2;
        start <= '1';
        WAIT FOR clk_period * 80;
        start <= '0';

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;