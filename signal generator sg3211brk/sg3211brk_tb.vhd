library ieee; 
use ieee.std_logic_1164.all; 

entity sg3211brk_tb is 
end entity; 

architecture behavioural of sg3211brk_tb is 
    component sg3211brk is 
        port (
            --defining the input and output ports 
            reset : in std_logic;
            start : in std_logic;
            clk   : in std_logic;
            y_out : out std_logic
        );
        end component sg3211brk; 

signal reset : std_logic := '0'; 
signal start : std_logic := '0'; 
signal clk   : std_logic := '0'; 
signal y_out : std_logic := '0'; 

constant clk_period : time := 10 ns; 

begin 

    uut : sg3211brk
        port map(
                reset => reset,
                start => start,
                clk   => clk  ,
                y_out  => y_out);                                 

    --clock signal declaration 
    clk_p : process 
    begin 
        clk <= '0'; 
        wait for clk_period/2; 
        clk <= '1'; 
        wait for clk_period/2; 
    end process clk_p; 

    stim_p : process
    begin 
        wait for clk_period; 
        reset <= '1'; 
        wait for clk_period; 
        reset <= '0'; 
        wait for clk_period; 
        start <= '1'; 
        wait for clk_period*20; 
        start <= '0'; 
        wait for clk_period; 
        wait; 
    end process stim_p; 
end behavioural; 