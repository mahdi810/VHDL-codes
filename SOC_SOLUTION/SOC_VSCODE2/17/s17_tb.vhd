LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s17_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s17_tb IS
    COMPONENT s17 IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            start : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            iter : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            fout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT s17;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, start, done : STD_LOGIC;
    SIGNAL iter : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL fout : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s17
    PORT MAP(
        clk => clk,
        reset => reset,
        start => start,
        done => done,
        iter => iter,
        fout => fout
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        iter <= STD_LOGIC_VECTOR(to_signed(20, iter'length));
        reset <= '0';
        start <= '1';
        WAIT FOR clk_period;
        start <= '0';
        WAIT FOR clk_period;

        WAIT;
    END PROCESS;
END ARCHITECTURE behavioral;