LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s23_3_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s23_3_tb IS
    COMPONENT s23_3 IS
        PORT (
            clk : IN STD_LOGIC;
            u : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            s_out : OUT STD_LOGIC);
    END COMPONENT s23_3;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL u : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_out : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generation 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s23_3
    PORT MAP(
        clk => clk,
        u => u,
        s_out => s_out
    );

    --stimulus process 
    stim_p : PROCESS
    BEGIN
        u <= "00";
        WAIT FOR clk_period * 5;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;