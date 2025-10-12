-- Engineer : Mohammad Mahdi Mohammadi

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity p1_ff_tb is
end entity p1_ff_tb;

architecture behavioural of p1_ff_tb is 
    component p1_ff is 
        port ( clk     : in  std_logic;
               enable  : in  std_logic; 
               reset   : in  std_logic;
               d       : in  std_logic_vector(3 downto 0);
               q       : out std_logic_vector(3 downto 0));
        end component p1_ff; 
    
    signal clk, reset, enable : std_logic := '0'; 
    signal d, q : std_logic_vector(3 downto 0) := x"0"; 
    constant clk_periode : time := 10 ns; 

begin 

	clk_p : process
	begin	
		clk <= '0'; 
		wait for clk_periode/2; 
		clk <= '1'; 
		wait for clk_periode/2; 
	end process clk_p;

    uut : p1_ff
        port map (  clk   =>  clk, 
                    enable => enable,   
                    reset => reset,   
                    d     => d, 
                    q     => q );

    stim_p : process
    begin 
		wait for clk_periode; 
		d <= x"5"; 
        reset <= '0'; 
        enable <= '1';  
        wait for clk_periode*3; 
        reset <= '1'; 
        enable <= '0'; 
        d <= "0000"; 
		wait for clk_periode*2; 
    wait; 
    end process stim_p; 

end behavioural; 