LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_3a_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s16_3a_tb IS
    COMPONENT s16_3a IS
        PORT (
            clk : IN STD_LOGIC;
            s : IN STD_LOGIC;
            x, y : OUT STD_LOGIC
        );
    END COMPONENT s16_3a;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL s, x, y : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s16_3a
    PORT MAP(
        clk => clk,
        s => s,
        x => x,
        y => y
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        s <= '0';
        WAIT FOR clk_period * 20;
        s <= '1';
        WAIT FOR clk_period * 20;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;