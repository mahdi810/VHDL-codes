LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s25_tb IS
    COMPONENT s25 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            x_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT s25;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start, done : STD_LOGIC;
    SIGNAL x_in : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL y : STD_LOGIC_VECTOR(15 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s25
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        done => done,
        x_in => x_in,
        y => y
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        start <= '1';
        reset <= '0';
        x_in <= STD_LOGIC_VECTOR(to_signed(16384, x_in'length));
        WAIT FOR clk_period;
        start <= '0';
        WAIT FOR clk_period * 100;
        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;