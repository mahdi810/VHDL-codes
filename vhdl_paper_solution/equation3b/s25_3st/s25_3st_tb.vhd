LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25_3st_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s25_3st_tb IS
    COMPONENT s25_3st IS
        PORT (
            clk : IN STD_LOGIC;
            d_in : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL d_in : STD_LOGIC := '0';
    SIGNAL y : STD_LOGIC_VECTOR(1 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clcok generation 
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- instantiate the Unit Under Test (UUT)
    uut : s25_3st PORT MAP(
        clk => clk,
        d_in => d_in,
        y => y
    );

    -- stimulus process
    stim_proc : PROCESS
    BEGIN
        -- hold reset state for 100 ns.
        WAIT FOR clk_period * 4;
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';
        WAIT FOR clk_period;
        d_in <= '1';
        WAIT FOR clk_period;
        d_in <= '0';

        WAIT;
    END PROCESS stim_proc;
END ARCHITECTURE behavioral;