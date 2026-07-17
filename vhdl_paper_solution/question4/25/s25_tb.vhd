LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s25_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s25_tb IS
    COMPONENT s25 IS
        GENERIC (
            DATA_NBITS : INTEGER := 10
        );
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            meas_on : IN STD_LOGIC;
            d_in : IN STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0);
            sign_cnt : OUT STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0)
        );
    END COMPONENT s25;

    CONSTANT DATA_NBITS : INTEGER := 10;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, meas_on : STD_LOGIC := '0';
    SIGNAL d_in : STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sign_cnt : STD_LOGIC_VECTOR(DATA_NBITS - 1 DOWNTO 0) := (OTHERS => '0');

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s25
    GENERIC MAP(
        DATA_NBITS => DATA_NBITS
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        meas_on => meas_on,
        d_in => d_in,
        sign_cnt => sign_cnt
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        WAIT FOR clk_period * 3;
        d_in <= STD_LOGIC_VECTOR(to_signed(10, d_in'length));
        WAIT FOR clk_period * 2;
        meas_on <= '1';
        WAIT FOR clk_period;
        d_in <= STD_LOGIC_VECTOR(to_signed(8, d_in'length));
        WAIT FOR clk_period;
        d_in <= STD_LOGIC_VECTOR(to_signed(15, d_in'length));
        WAIT FOR clk_period;
        d_in <= STD_LOGIC_VECTOR(to_signed(-14, d_in'length));
        WAIT FOR clk_period;
        d_in <= STD_LOGIC_VECTOR(to_signed(8, d_in'length));
        WAIT FOR clk_period;
        d_in <= STD_LOGIC_VECTOR(to_signed(-12, d_in'length));
        WAIT FOR clk_period;
        d_in <= STD_LOGIC_VECTOR(to_signed(-20, d_in'length));
        WAIT FOR clk_period;
        d_in <= STD_LOGIC_VECTOR(to_signed(20, d_in'length));
        WAIT FOR clk_period;
        meas_on <= '0';
        d_in <= STD_LOGIC_VECTOR(to_signed(-50, d_in'length));
        WAIT FOR clk_period;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;