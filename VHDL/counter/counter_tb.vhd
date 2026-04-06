library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end counter_tb;

architecture fizzim of counter_tb is
    component counter is
        port (
            count : out std_logic;
            clock : in std_logic;
            start : in std_logic
        );
    end component counter;
    signal count, clock, start : std_logic := '0';

    constant clk_period : time := 10 ns;

begin

    --clock generation 
    clock <= not clock after clk_period/2;

    --unit under test isntantiation 
    uut : entity work.counter
    port map(
        count => count,
        clock => clock,
        start => start
    );

    --stimulus 
    stim_p : process 
    begin 
        start <= '0'; 
        wait for clk_period * 3; 
        start <= '1'; 
        wait for clk_period * 15; 


        wait; 
    end process stim_p; 



end fizzim;