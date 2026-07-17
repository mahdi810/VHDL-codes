LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s15_2_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s15_2_tb IS
    COMPONENT s15_2 IS
        GENERIC (
            NBITS : INTEGER := 12
        );
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            pval : IN STD_LOGIC_VECTOR(NBITS - 1 DOWNTO 0);
            pwmout : OUT STD_LOGIC
        );
    END COMPONENT s15_2;
    CONSTANT NBITS : INTEGER := 12;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, enable, pwmout : STD_LOGIC;
    SIGNAL pval : STD_LOGIC_VECTOR(NBITS - 1 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s15_2
    GENERIC MAP(
        NBITS => NBITS
    )
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => enable,
        pval => pval,
        pwmout => pwmout
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        reset <= '0';
        enable <= '1';
        pval <= STD_LOGIC_VECTOR(to_signed(2730, pval'length));
        WAIT FOR clk_period * 500;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;