LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s23_tb IS
    COMPONENT s23 IS
        PORT (
            clk : IN STD_LOGIC;
            u1 : IN STD_LOGIC;
            u0 : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT s23;
    SIGNAL u1, u0 : STD_LOGIC;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL y : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : s23
    PORT MAP(
        clk => clk,
        u1 => u1,
        u0 => u0,
        y => y
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        u1 <= '0';
        u0 <= '1';
        WAIT FOR clk_period * 12;

        -- u0 <= '0';
        -- u1 <= '1';
        -- WAIT FOR clk_period * 4;

        -- u0 <= '1';
        -- u1 <= '0';
        -- WAIT FOR clk_period * 4;

        -- u0 <= '1';
        -- u1 <= '1';
        -- WAIT FOR clk_period * 4;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;