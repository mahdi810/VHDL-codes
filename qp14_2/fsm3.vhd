library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm3 is 
    port( s : in std_logic; 
          x : out std_logic_vector(1 downto 0); 
          clk : in std_logic ); 
end fsm3; 

architecture rtl of fsm3 is 
    signal Q : std_logic_vector(3 downto 0) := (others => '0'); 
    signal a, b, c, d, e, f : std_logic; 

begin 
    
    a <= Q(3) AND (NOT Q(2)); 
    b <= Q(0) XOR a; 
    c <= (NOT a) AND Q(1); 
    d <= Q(1) AND (NOT Q(0)); 
    e <= a AND (NOT Q(1)) AND Q(0); 
    x(1) <= Q(1); 
    x(0) <= Q(0); 

    seq_p : process(clk)
    begin 
        if rising_edge(clk) then 
            Q(0) <= b; 
            Q(1) <= f; 
            Q(2) <= Q(3); 
            Q(3) <= s; 
        end if; 
    end process seq_p; 
end rtl; 