LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_3_1b_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s16_3_1b_tb IS
    COMPONENT s16_3_1b IS
        PORT (
            clk : IN STD_LOGIC;
            u : IN STD_LOGIC;
            x : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT s16_3_1b;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL u : STD_LOGIC := '0';
    SIGNAL x : STD_LOGIC_VECTOR(1 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock genertion 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s16_3_1b
    PORT MAP(
        clk => clk,
        u => u,
        x => x
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        u <= '1';
        WAIT FOR clk_period * 5;

        u <= '0';
        WAIT FOR clk_period * 5;

        WAIT;
    END PROCESS;
END ARCHITECTURE behavioral;