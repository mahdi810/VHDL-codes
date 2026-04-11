library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_resptst_tb is
end entity;

architecture bhv of fsm_resptst_tb is
    component fsm_resptst is
        port (
            clk, reset : in std_logic;
            b0, b1, b2 : in std_logic;
            led0, led1, led2, ledg, ledr : out std_logic
        );
    end component fsm_resptst;
    signal clk, reset, b0, b1, b2, led0, led1, led2, ledg, ledr : std_logic := '0';
    constant clk_period : time := 10 ns;

begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : entity work.fsm_resptst
        port map(
            clk => clk,
            reset => reset,
            b0 => b0,
            b1 => b1,
            b2 => b2,
            led0 => led0,
            led1 => led1,
            led2 => led2,
            ledg => ledg,
            ledr => ledr
        );

    --stimulus process 
    stim_p : process
    begin
        reset <= '0'; 
        wait for clk_period * 2; 
        reset <= '1'; 
        wait for clk_period * 2; 
        reset <= '0'; 
        wait for clk_period * 3; 
        b0 <= '1'; 
        wait for clk_period * 4; 
        b0 <= '0'; 
        wait for clk_period * 2; 
        b1 <= '1'; 
        wait for clk_period * 5; 
        b1 <= '0'; 

        wait; 
    end process;
end bhv;