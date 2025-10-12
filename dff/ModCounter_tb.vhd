library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity ModCounter_tb is 
end entity; 

architecture bhv of ModCounter_tb is 
    component ModCounter is 
        generic ( N : integer :=  4; --number of bits
                  M : integer := 10); --mode counter) 
        port ( clk, reset : in std_logic; 
               max_tick : out std_logic; 
               q : out std_logic_vector(N-1 downto 0));
    end component ModCounter; 
    constant N : integer := 4;
    constant M : integer := 10;  
    signal clk, reset, max_tick : std_logic := '0'; 
    signal q : std_logic_vector(N-1 downto 0) := (others => '0');

    constant clk_periode : time := 10 ns; 

begin 

    --clock generation 
    clk_p : process
    begin 
        clk <= '0'; 
        wait for clk_periode/2; 
        clk <= '1'; 
        wait for clk_periode/2; 
    end process; 

    uut : ModCounter 
        generic map( N => N, 
                     M => M )
        port map( clk => clk, 
                  reset => reset, 
                  max_tick => max_tick, 
                  q => q ); 
                  
    stim_p : process
    begin 
        reset <= '0'; 
        wait for clk_periode * 30; 



        wait; 
    end process stim_p; 


end bhv; 