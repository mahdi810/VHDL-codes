library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm4 is 
    port(
        clk : in std_logic; 
        d : in std_logic; 
        pha, phb : out std_logic
    ); 
end fsm4;

architecture structural of fsm4 is 
    signal q : std_logic_vector(1 downto 0) := (others => '0');  
    signal a, b, c, e, f : std_logic := '0'; 
begin 

    --combinational 
    a <= (NOT d) AND (NOT q(1)) AND q(0);
    b <= (NOT d) AND q(1) AND (NOT q(0)); 
    c <= d AND (NOT q(1)) AND (NOT q(0)); 
    e <= d AND q(1) AND q(0); 
    f <= a or b or c or e; 

    --flipflops 
    ff : process (clk)
    begin
        if rising_edge(clk) then 
            q(1) <= f; 
            q(0) <= NOT q(0);  
        end if; 
    end process;

    --output 
    pha <= q(1); 
    phb <= q(0); 
end structural; 