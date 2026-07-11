LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3a_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s23_3a_tb IS
    COMPONENT s23_3a IS
        PORT (
            clk : IN STD_LOGIC;
            u : IN STD_LOGIC;
            x : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT s23_3a;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL u : STD_LOGIC;
    SIGNAL x : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL y : STD_LOGIC_VECTOR(2 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    --unit under test 
    uut : s23_3a
    PORT MAP(
        clk => clk,
        u => u,
        x => x,
        y => y
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        x <= "001";
        u <= '1';
        WAIT FOR clk_period * 10;

        u <= '0';
        WAIT FOR clk_period * 10;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;