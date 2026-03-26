library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter_tb is
end barrel_shifter_tb;

architecture bhv of barrel_shifter_tb is
    component barrel_shifter is
        port (
            a : in std_logic_vector(7 downto 0);
            amt : in std_logic_vector(2 downto 0);
            y : out std_logic_vector(7 downto 0));
    end component barrel_shifter;
    signal a, y : std_logic_vector(7 downto 0) := ((others => '0'));
    signal amt : std_logic_vector(2 downto 0) := ((others => '0'));

begin

    --unit under test 
    uut : entity work.barrel_shifter
        port map(
            a => a,
            amt => amt,
            y => y
        );

    --stimulus 
    stim_p : process 
    begin 
        a <=  x"80";
        amt <= "011";
        wait for 20 ns;   


    wait; 
    end process stim_p; 
end bhv;