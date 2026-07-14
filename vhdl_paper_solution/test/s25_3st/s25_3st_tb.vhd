LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25_3st_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s25_3st_tb IS
    COMPONENT s25_3st IS
        PORT (
            d_in : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL d_in : STD_LOGIC;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL y : STD_LOGIC_VECTOR(1 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk_p : PROCESS
    BEGIN
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
        clk <= '0';
    END PROCESS;

    --unit under test 
    uut : s25_3st
    PORT MAP(
        clk => clk,
        d_in => d_in,
        y => y
    );

    --stimulus process
    stim_p : PROCESS
    BEGIN
        FOR k IN 0 TO 5 LOOP
            d_in <= '0';
            WAIT FOR clk_period;
            d_in <= '1';
            WAIT FOR clk_period;
        END LOOP;

        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';
        WAIT FOR clk_period * 6;

        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT FOR clk_period * 6;

        WAIT;
    END PROCESS stim_p;

END ARCHITECTURE behavioral;