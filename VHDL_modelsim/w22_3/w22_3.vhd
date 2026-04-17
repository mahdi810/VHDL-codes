library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity w22_3 is
    port (
        clk : in std_logic; 
        y : out std_logic_vector(3 downto 0)
    );
end w22_3;

architecture bhv of w22_3 is

    signal q : std_logic_vector(3 downto 0) := (others => '0'); 
    signal a, b, c, d, e : std_logic := '0';  

begin

    a <= (NOT q(3)) AND q(2) AND q(1) AND q(0); 
    b <= (NOT q(0)) AND a; 
    c <= q(3) AND a; 
    d <= q(2) AND a; 
    e <= q(1) AND a; 
    y(0) <= q(3); 
    y(1) <= q(2); 
    y(2) <= q(1); 
    y(3) <= q(0); 


    --flipflops 
    ff : process (clk)
    begin
        if rising_edge(clk) then 
            q(0) <= e; 
            q(1) <= d; 
            q(2) <= c; 
            q(3) <= b; 
        end if; 
    end process;

end bhv ; -- bhv