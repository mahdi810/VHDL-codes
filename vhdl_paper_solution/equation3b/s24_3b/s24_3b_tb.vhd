LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24_3b_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s24_3b_tb IS
    COMPONENT s24_3b IS
        PORT (
            clk : IN STD_LOGIC;
            d_in : IN STD_LOGIC;
            sel : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
        );
    END COMPONENT s24_3b;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL d_in, sel : STD_LOGIC;
    SIGNAL y : STD_LOGIC_VECTOR(4 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN
    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : s24_3b
    PORT MAP(
        clk => clk,
        d_in => d_in,
        sel => sel,
        y => y
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        sel <= '0';
        d_in <= '0';
        WAIT FOR clk_period * 5;

        sel <= '0';
        d_in <= '1';
        WAIT FOR clk_period * 5;

        sel <= '1';
        d_in <= '0';
        WAIT FOR clk_period * 5;

        sel <= '1';
        d_in <= '1';
        WAIT FOR clk_period * 5;

    END PROCESS;
END ARCHITECTURE behavioral;