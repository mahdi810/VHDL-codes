library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fib2_tb is
end fib2_tb;

architecture behavioral of fib2_tb is
    component fib2 is
        port (
            clk, reset, start : in std_logic;
            s_num : in integer;
            y_out : out integer;
            done : out std_logic
        );
    end component fib2;

    signal clk, reset, start, done : std_logic := '0';
    signal s_num : integer := 0;
    signal y_out : integer := 0;

    constant clk_period : time := 10 ns;

begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : entity work.fib2
        port map(
            clk => clk,
            reset => reset,
            start => start,
            s_num => s_num,
            y_out => y_out,
            done => done
        );

    stim_p : process 
    begin
        s_num <= 20; 
        reset <= '1'; 
        start <= '0'; 
        wait for clk_period * 5; 
        reset <= '0'; 
        start <= '1'; 
        wait for clk_period * 25; 

    end process;
end behavioral;