LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_2_bhv_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s16_2_bhv_tb IS
    COMPONENT s16_2_bhv IS
        PORT (
            clk : IN STD_LOGIC;
            s : IN STD_LOGIC;
            x : OUT STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT s16_2_bhv;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL s, x, y : STD_LOGIC := '0';

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clk generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s16_2_bhv
    PORT MAP(
        clk => clk,
        s => s,
        x => x,
        y => y
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        s <= '0';
        WAIT FOR clk_period * 6;

        s <= '1';

        WAIT FOR clk_period * 10;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;