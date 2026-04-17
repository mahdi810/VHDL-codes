library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity w22_2_tb is
end entity;

architecture bhv of w22_2_tb is
    component w22_2 is
        port (
            clk : in std_logic;
            b : in std_logic_vector(1 downto 0);
            y : out std_logic
        );
    end component w22_2;
    signal clk, y : std_logic := '0';
    signal b : std_logic_vector(1 downto 0) := (others => '0');
    constant clk_period : time := 10 ns;
begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : w22_2
        port map(
            clk => clk,
            b => b,
            y => y
        );

    --stimulus process 
    stim_p : process 
    begin 
        b <= "11"; 
        wait for clk_period * 50; 
        b <= "10"; 
        wait for clk_period * 50; 


        wait; 
    end process stim_p; 
end bhv; -- bhv