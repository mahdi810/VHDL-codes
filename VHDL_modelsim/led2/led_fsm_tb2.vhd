library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_fsm2_tb is
end entity;

architecture bhv of led_fsm2_tb is
    component led_fsm2 is
        port (
            clk, reset : in std_logic;
            b0 : in std_logic;
            L : out std_logic_vector(2 downto 0)
        );
    end component led_fsm2;
    signal clk, reset, b0 : std_logic := '0';
    signal L : std_logic_vector(2 downto 0) := (others => '0');
    constant clk_period : time := 10 ns;
begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : entity work.led_fsm2
        port map(
            clk => clk,
            reset => reset,
            b0 => b0,
            L => L
        );

    --stimulus process 
    stim_p : process 
    begin
        b0 <= '1'; 
        reset <=  '1'; 
        wait for clk_period * 3; 
        reset <=  '0'; 
        wait for clk_period * 4; 
        b0 <= '0'; 
        wait for clk_period * 5; 
        b0 <= '1'; 
        wait for clk_period * 10; 

        wait; 
    end process;
end bhv;