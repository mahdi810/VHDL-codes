library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter2bit_tb is
end counter2bit_tb;

architecture bhv of counter2bit_tb is
    component counter2bit is
        port (
            count : out std_logic_vector(1 downto 0);
            clk : in std_logic;
            resetN : in std_logic;
            start : in std_logic
        );
    end component counter2bit;
    signal count : std_logic_vector(1 downto 0) := (others => '0');
    signal clk, start : std_logic := '0';
    signal resetN : std_logic := '1';
    constant clk_period : time := 10 ns;

begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : entity work.counter2bit
        port map(
            clk => clk,
            resetN => resetN,
            count => count,
            start => start);

    --stimulus process 
    stim_p : process 
    begin 
        start <= '0'; 
        resetN <= '0'; 
        wait for clk_period * 2; 
        resetN <= '1'; 
        start <= '1'; 
        wait for clk_period * 10; 
        start <= '0'; 
        wait for clk_period * 4; 
        resetN <= '1'; 
        wait for clk_period * 5; 

        wait; 
    end process stim_p; 

end bhv;