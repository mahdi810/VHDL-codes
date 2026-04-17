library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity w22_3_tb is
end w22_3_tb;

architecture bhv of w22_3_tb is
    component w22_3 is
        port (
            clk : in std_logic;
            y : out std_logic_vector(3 downto 0)
        );
    end component w22_3;
    signal clk : std_logic := '0';
    signal y : std_logic_vector(3 downto 0) := (others => '0');
    constant clk_period : time := 10 ns;
begin

    --clock generation 
    clk_p : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    --unit under test 
    uut : w22_3
        port map(
            clk => clk,
            y => y
        );

    --stimulus process 
    stim_p : process 
    begin
        wait for clk_period * 20; 


        wait; 
    end process;

end bhv; -- bhv