LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s20_tb IS
END ENTITY s20_tb;

ARCHITECTURE behavioral OF s20_tb IS
    COMPONENT s20 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            u : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            yout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT s20;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start, done : STD_LOGIC;
    SIGNAL u, yout : STD_LOGIC_VECTOR(15 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test
    uut : s20
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        done => done,
        u => u,
        yout => yout
    );

    -- stimulus process
    stim_p : PROCESS
    BEGIN
        start <= '1';
        reset <= '0';
        u <= STD_LOGIC_VECTOR(to_signed(4915, u'length));
        WAIT FOR clk_period;
        start <= '0';
        WAIT FOR clk_period * 100;

        WAIT;
    END PROCESS stim_p;
END ARCHITECTURE behavioral;