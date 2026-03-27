library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity string_detector111_tb is 
end string_detector111_tb; 

architecture behavioral of string_detector111_tb is 
    component string_detector111 is 
        port (
            clk : in std_logic;
            reset : in std_logic;
            d : in std_logic; 
            q : out std_logic); --output 
    end component string_detector111; 
    constant clk_period : time := 10 ns; 
    signal reset, q : std_logic;
    signal clk, d: std_logic := '0';
    signal data : std_logic_vector(8 downto 0) := "011101100";  
begin 

    --clock generation 
    clk <= NOT clk after clk_period/2; 

    uut :  entity work.string_detector111
        port map(
            clk => clk,
            reset => reset,
            d => d,
            q => q
            );

    stim_p : process 
    begin
        reset <= '1'; 
        wait for clk_period; 
        reset <= '0'; 
        for k in 0 to 8 loop  
            d <= data(k); 
            wait for clk_period; 
        end loop; 




    wait;       
    end process;



end behavioral; 