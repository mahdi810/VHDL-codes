LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY s16_1_tb IS
END ENTITY;

ARCHITECTURE behavioral OF s16_1_tb IS
    COMPONENT s16_1 IS
        PORT (
            clk : IN STD_LOGIC;
            s : IN STD_LOGIC;
            xy : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL xy : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL s : STD_LOGIC := '0';

    CONSTANT clk_period : TIME := 10 ns;
BEGIN

    -- clock generatin 
    clk <= NOT clk AFTER clk_period/2;

    -- unit under test 
    uut : s16_1
    PORT MAP(
        clk => clk,
        s => s,
        xy => xy
    );

    -- stimulus process 
    stim_p : PROCESS
    BEGIN
        s <= '1';
        WAIT FOR clk_period * 5;

        s <= '0';
        WAIT FOR clk_period * 5;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;