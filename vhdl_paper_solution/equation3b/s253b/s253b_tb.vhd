LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s253b_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s253b_tb IS
    COMPONENT s253b IS
        PORT (
            clk : IN STD_LOGIC;
            d_in : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT s253b;
    SIGNAL clk : STD_LOGIC := '0';

    SIGNAL d_in : STD_LOGIC;
    SIGNAL y : STD_LOGIC_VECTOR(1 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s253b
    PORT MAP(
        clk => clk,
        d_in => d_in,
        y => y
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT FOR clk_period * 5;
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT FOR clk_period * 5;
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT FOR clk_period * 5;
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT FOR clk_period * 5;
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT FOR clk_period * 5;
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT FOR clk_period * 5;
        -- d_in <= '1';
        -- WAIT FOR clk_period;
        -- d_in <= '0';

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;