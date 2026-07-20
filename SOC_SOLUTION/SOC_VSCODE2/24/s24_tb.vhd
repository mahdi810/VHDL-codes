LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s24_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s24_tb IS
    COMPONENT s24 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            xin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            yout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start, done : STD_LOGIC;
    SIGNAL xin : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL yout : STD_LOGIC_VECTOR(15 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s24
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        done => done,
        xin => xin,
        yout => yout
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        start <= '1';
        xin <= STD_LOGIC_VECTOR(to_signed(8388608, xin'length));
        WAIT FOR clk_period;
        start <= '0';
        WAIT FOR clk_period * 50;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;