LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_tb IS
END ENTITY s16_tb;

ARCHITECTURE behavioral OF s16_tb IS
    COMPONENT s16 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            incr : IN STD_LOGIC;
            stop : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC
        );
    END COMPONENT s16;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start, stop, incr, clk_out : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s16
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        incr => incr,
        stop => stop,
        clk_out => clk_out
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        start <= '0';
        reset <= '0';
        incr <= '0';
        stop <= '0';
        WAIT FOR clk_period * 200;
        start <= '1';
        WAIT FOR clk_period * 60;
        start <= '0';
        WAIT FOR clk_period * 200;
        incr <= '1';
        WAIT FOR clk_period * 60;
        incr <= '0';
        WAIT FOR clk_period * 200;
        stop <= '1';
        WAIT FOR clk_period * 60;
        stop <= '0';
        WAIT FOR clk_period * 30;

        WAIT;
    END PROCESS;
END ARCHITECTURE behavioral;