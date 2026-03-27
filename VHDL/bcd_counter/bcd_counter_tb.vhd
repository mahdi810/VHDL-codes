library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity bcd_counter_tb is 
end bcd_counter_tb; 

architecture behavioral of bcd_counter_tb is 
    component bcd_counter is 
        port(
            clk : in std_logic; 
            reset : in std_logic; 
            count : out std_logic_vector(3 downto 0)
            ); 
    end component bcd_counter; 
    signal clk, reset : std_logic := '0';
    signal count : std_logic_vector(3 downto 0) := ((others => '0') ); 
    constant clk_period : time := 10 ns; 

begin 

    --clock generation 
    clk <= not clk after clk_period/2; 

    uut : entity work.bcd_counter 
        port map(clk => clk, 
                reset => reset, 
                count => count); 

    stim_p : process
    begin
        reset <= '1'; 
        wait for clk_period * 3; 
        reset <= '0'; 
        wait for clk_period * 15; 

        wait; 
    end process;



end behavioral; 