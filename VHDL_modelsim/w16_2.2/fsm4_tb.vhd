library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsm4_tb is 
end fsm4_tb;

architecture behavioral of fsm4_tb is 
    signal clk : std_logic := '0'; 
    signal d : std_logic := '0'; 
    signal pha, phb : std_logic; 
    constant clk_period : time := 10 ns;

    component fsm4 is 
        port(
            clk : in std_logic; 
            d : in std_logic; 
            pha, phb : out std_logic
        ); 
    end component;
begin 

    --unit under test 
    uut: fsm4 port map (
        clk => clk, 
        d => d, 
        pha => pha, 
        phb => phb
    );

    --clock generation 
    clk <= NOT clk after clk_period/2;

    --stimulus process
    stimulus: process
    begin
        d <= '0';
        wait for clk_period * 10;
        d <= '1'; 
        wait for clk_period * 10; 

        wait; 
    end process stimulus; 

end behavioral;