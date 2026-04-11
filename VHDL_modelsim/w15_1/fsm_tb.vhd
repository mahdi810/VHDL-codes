library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_tb is

end fsm_tb;

architecture structural of fsm_tb is
    component fsm is
        port (
            x_in : in std_logic;
            clk, reset : in std_logic;
            y_out : out std_logic_vector(1 downto 0)
        );
    end component fsm;
    signal x_in, clk, reset : std_logic := '0';
    signal y_out : std_logic_vector(1 downto 0) := (others => '0');
    constant clk_period : time := 10 ns; --100MHz clk 
begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    fsm_inst : entity work.fsm
        port map(
            x_in => x_in,
            clk => clk,
            reset => reset,
            y_out => y_out
        );

    --stimulus process 
    stim_p : process
    begin
        reset <= '1'; 
        x_in <=  '0'; 
        wait for clk_period * 2; 
        reset <= '0'; 
        wait for clk_period * 10; 
        x_in <= '1'; 
        wait for clk_period * 10; 
        reset <= '1'; 
        wait for clk_period * 4; 
        reset <= '0';
        for k in 0 to 20 loop 
            x_in <= '1'; 
            wait for clk_period; 
        end loop; 

        wait; 
    end process;

end structural;