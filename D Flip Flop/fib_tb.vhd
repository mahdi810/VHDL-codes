library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity fib_tb is 
end entity; 

architecture bhv of fib_tb is 
    component fib is 
        port( clk, reset, start : in std_logic; 
          y_out : out unsigned(31 downto 0); 
          n : in integer );
    end component fib; 
    signal clk, reset, start : std_logic := '0'; 
    signal y_out : unsigned(31 downto 0) := (others => '0'); 
    constant clk_periode : time := 10 ns; 
    signal n : integer := 0; 

begin 

    --clock generation 
    clk_p : process
    begin
        clk <= '0';
        wait for clk_periode /2; 
        clk <= '1'; 
        wait for clk_periode/2; 
    end process clk_p; 

    uut : fib 
        port map( clk => clk, 
                  reset => reset, 
                  start => start, 
                  n => n, 
                  y_out => y_out ); 


    stim_p : process 
    begin 
        reset <= '1'; 
        start <= '0'; 
        n <= 15; 
        wait for clk_periode; 
        reset <= '0'; 
        start <= '1'; 
        wait for clk_periode * 20;


        wait; 
    end process stim_p; 




end bhv; 