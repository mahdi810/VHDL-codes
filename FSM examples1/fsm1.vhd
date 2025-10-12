library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm1 is 
    port( y : in std_logic; 
          x : out std_logic; 
          clk : in std_logic ); 
end fsm1; 

architecture rtl of fsm1 is 
    signal Q : std_logic_vector(3 downto 0) := (others => '0'); 
    signal a, b : std_logic; 

begin 
    x <= Q(3); 
    a <= Q(3) XOR Q(2); 
    b <= y OR a; 
    
    seq_p : process(clk)
    begin 
        if rising_edge(clk) then 
            Q(0) <= b; 
            Q(1) <= Q(0); 
            Q(2) <= Q(1); 
            Q(3) <= Q(2); 
        end if; 
    end process seq_p; 
end rtl; 