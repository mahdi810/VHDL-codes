LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st1_bhv_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s14_st1_bhv_tb IS
    COMPONENT s14_st1_bhv IS
        PORT (
            clk : IN STD_LOGIC;
            u : IN STD_LOGIC;
            x : OUT STD_LOGIC
        );
    END COMPONENT s14_st1_bhv;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL u, x : STD_LOGIC := '0';

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uu : s14_st1_bhv
    PORT MAP(
        clk => clk,
        u => u,
        x => x
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        u <= '0';
        WAIT FOR clk_period * 20;

        u <= '1';
        WAIT FOR clk_period * 20;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;