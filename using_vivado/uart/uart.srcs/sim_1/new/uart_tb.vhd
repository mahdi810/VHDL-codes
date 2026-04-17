library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tb is
end uart_tb;

architecture bhv of uart_tb is
    component uart is
        port (
            clk, start, reset : in std_logic;
            txdata : in std_logic_vector(7 downto 0);
            TxD : out std_logic;
            done : out std_logic
        );
    end component uart;
    signal clk, reset, start, TxD, done : std_logic := '0';
    constant clk_period : time := 10 ns;
    signal txdata : std_logic_vector(7 downto 0) := (others => '0');

begin

    --clock generation 
    clk_p : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process clk_p;

    --unit under test 
    uart_inst : entity work.uart
        port map(
            clk => clk,
            start => start,
            reset => reset,
            txdata => txdata,
            TxD => TxD,
            done => done
        );

        --stimulus process 
        stim_p : process 
        begin 
            start <= '0'; 
            reset <= '1'; 
            txdata <= x"12"; 
            wait for clk_period * 3; 
            reset <= '0'; 
            wait for clk_period; 
            start <= '1'; 
            wait for clk_period; 
            start <= '0'; 
            wait for clk_period * 20; 
            
            wait; 
        end process stim_p;     

end bhv;