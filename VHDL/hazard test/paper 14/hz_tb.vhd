library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity hz_tb is 
end hz_tb; 

architecture structural of hz_tb is 
component hz0 is 
port(
      a, b, c, d : in std_logic; 
      y : out std_logic
); 
end component hz0; 
constant clk_periode : time := 10 ns; 
signal x, z, y, a, b, c, d : std_logic := '0'; 

begin
    uut : hz0 
    port map(
        a => a, 
        b => b, 
        c => c,
        d => d,  
        y => y
    ); 

    stim_p : process
    begin 
    a <= '0'; 
    b <= '0'; 
    c <= '0'; 
    d <= '0'; 
    wait for clk_periode; 
    a <= '1'; 
    b <= '0'; 
    c <= '0'; 
    d <= '0'; 
    wait for clk_periode;
    a <= '0'; 
    b <= '1'; 
    c <= '0';
    d <= '0';  
    wait for clk_periode;
    a <= '1'; 
    b <= '1'; 
    c <= '0';
    d <= '0';  
    wait for clk_periode;
    a <= '0'; 
    b <= '0'; 
    c <= '1';
    d <= '0';  
    wait for clk_periode;
    a <= '1'; 
    b <= '0'; 
    c <= '1'; 
    d <= '0'; 
    wait for clk_periode;
    a <= '0'; 
    b <= '1'; 
    c <= '1'; 
    d <= '0'; 
    wait for clk_periode;
    a <= '1'; 
    b <= '1'; 
    c <= '1'; 
    d <= '0'; 
    wait for clk_periode;
    a <= '0'; 
    b <= '0'; 
    c <= '0'; 
    d <= '1'; 
    wait for clk_periode; 
    a <= '1'; 
    b <= '0'; 
    c <= '0'; 
    d <= '1'; 
    wait for clk_periode;
    a <= '0'; 
    b <= '1'; 
    c <= '0';
    d <= '1';  
    wait for clk_periode;
    a <= '1'; 
    b <= '1'; 
    c <= '0';
    d <= '1';  
    wait for clk_periode;
    a <= '0'; 
    b <= '0'; 
    c <= '1';
    d <= '1';  
    wait for clk_periode;
    a <= '1'; 
    b <= '0'; 
    c <= '1'; 
    d <= '1'; 
    wait for clk_periode;
    a <= '0'; 
    b <= '1'; 
    c <= '1'; 
    d <= '1'; 
    wait for clk_periode;
    a <= '1'; 
    b <= '1'; 
    c <= '1'; 
    d <= '1'; 
    wait for clk_periode;
    wait; 
end process stim_p; 

end structural; 