LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY w23_2_tb IS
END w23_2_tb;

ARCHITECTURE behavioral OF w23_2_tb IS
    COMPONENT w23_2 IS
        PORT (
            clk, reset : IN STD_LOGIC;
            u : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            s_out : OUT STD_LOGIC
        );
    END COMPONENT w23_2;
    SIGNAL clk, reset, s_out : STD_LOGIC := '0';
    SIGNAL u : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : w23_2
    PORT MAP(
        clk => clk,
        reset => reset,
        u => u,
        s_out => s_out
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '1';
        WAIT FOR clk_period;
        u <= "00";
        WAIT FOR clk_period;
        reset <= '0';
        WAIT FOR clk_period * 2;

        u <= "01";
        WAIT FOR clk_period * 4;

        u <= "10";
        WAIT FOR clk_period * 4;

        u <= "11";
        WAIT FOR clk_period * 4;
        WAIT;
    END PROCESS stim_p;
END behavioral; -- w23_2_tbehaviow