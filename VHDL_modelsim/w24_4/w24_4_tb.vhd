LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY w24_4_tb IS
END w24_4_tb;

ARCHITECTURE behavioral OF w24_4_tb IS

    COMPONENT w24_4 IS
        PORT (
            clk, reset, start : IN STD_LOGIC;
            y_out : OUT STD_LOGIC
        );
    END COMPONENT w24_4;
    SIGNAL clk, reset, start : STD_LOGIC := '0';
    SIGNAL y_out : STD_LOGIC := '0';
    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    w24_4_inst : w24_4
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        y_out => y_out
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        start <= '1';
        WAIT FOR clk_period * 40;

        WAIT;
    END PROCESS;

END behavioral; -- behavioral