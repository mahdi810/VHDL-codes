LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s16_1_tb IS
    COMPONENT s16_1 IS
        PORT (
            clk : IN STD_LOGIC;
            u : IN STD_LOGIC;
            x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT s16_1;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL u : STD_LOGIC;
    SIGNAL x : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clk generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s16_1
    PORT MAP(
        clk => clk,
        u => u,
        x => x
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        u <= '0';
        WAIT FOR clk_period * 6;

        u <= '1';

        WAIT FOR clk_period * 10;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;