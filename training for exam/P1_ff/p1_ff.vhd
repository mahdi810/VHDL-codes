-- engineer: Mohammad Mahdi Mohammadi 

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity p1_ff is
    port (
        clk     : in  std_logic;
        enable  : in  std_logic; 
        reset   : in  std_logic;
        d       : in  std_logic_vector(3 downto 0);
        q       : out std_logic_vector(3 downto 0)
    );
end entity p1_ff;

architecture behavioural of p1_ff is
begin 
	
    process(clk, reset)
    begin 
		
        if (enable = '1') then 
            if (reset = '1') then 
                q <= x"0"; 
            elsif (reset = '0') then 
                if rising_edge(clk) then 
                q <= d; 
                end if;
            end if;  
        end if; 
    end process;
end behavioural; 