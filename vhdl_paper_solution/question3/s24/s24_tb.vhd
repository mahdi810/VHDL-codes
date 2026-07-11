library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity s24_tb is
end entity;

architecture behavioral of s24_tb is
    component s24 is
    PORT (
            clk : IN STD_LOGIC;
            d_in : IN STD_LOGIC;
            sel : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
        );
    end component s24;
    signal d_in, sel : std_logic;
    signal clk: std_logic := '0';
    signal y : std_logic_vector(4 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- clock generation
    clk_p : process
    begin
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
    end process clk_p;

    -- unit under test
    uut :  s24
     port map(
        clk => clk,
        d_in => d_in,
        sel => sel,
        y => y
    );

    --stimulus process
    stim_p : process
    begin
        sel <= '0';
        d_in <= '0';
        wait for clk_period;
        d_in <= '1';
        wait for clk_period;
        d_in <= '0';
        wait for clk_period * 5;

        sel <= '1';
        d_in <= '0';
        wait for clk_period;
        d_in <= '1';
        wait for clk_period;
        d_in <= '0';
        wait for clk_period * 5;


    end process stim_p;



end behavioral;
