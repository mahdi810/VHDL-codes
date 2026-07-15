LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s14_st2_bhv_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s14_st2_bhv_tb IS
    COMPONENT s14_st2_bhv IS
        PORT (
            clk : IN STD_LOGIC;
            s : IN STD_LOGIC;
            x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT s14_st2_bhv;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL s : STD_LOGIC := '0';
    SIGNAL x : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clk generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s14_st2_bhv
    PORT MAP(
        clk => clk,
        s => s,
        x => x
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        WAIT FOR clk_period;
        s <= '0';
        WAIT FOR clk_period;
        s <= '1';
        WAIT FOR clk_period;
        WAIT FOR clk_period * 10;
        s <= '0';
        WAIT FOR clk_period;
        s <= '1';
        WAIT FOR clk_period;
        s <= '0';
        WAIT FOR clk_period;
        s <= '1';
        WAIT FOR clk_period;
        s <= '0';
        WAIT FOR clk_period;
        s <= '1';
        WAIT FOR clk_period;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;