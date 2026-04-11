library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm3_tb is
end fsm3_tb;

architecture bhv of fsm3_tb is
    component fsm3 is
        port (
            clk : in std_logic;
            reset, enable : in std_logic;
            ctr_err : in std_logic_vector(7 downto 0);
            heat, cool : out std_logic
        );
    end component fsm3;
    signal clk, reset, enable, heat, cool : std_logic := '0';
    signal ctr_err : std_logic_vector(7 downto 0) := (others => '0');
    constant clk_period : time := 10 ns;

begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : entity work.fsm3
        port map(
            clk => clk,
            reset => reset,
            enable => enable,
            ctr_err => ctr_err,
            heat => heat,
            cool => cool
        );

    --stimulus process 
    stim_p : process 
    begin
        reset <= '1'; 
        enable <= '0'; 
        ctr_err <= x"3c";
        wait for clk_period * 2; 
        reset <= '0'; 
        enable <= '0';
        wait for clk_period; 
        reset <= '0'; 
        enable <= '1';
        wait for clk_period * 5; 
        ctr_err <= x"32"; 
        wait for clk_period * 2; 
        ctr_err <= x"28"; 
        wait for clk_period * 2; 
        ctr_err <= x"20"; 
        wait for clk_period * 2; 
        ctr_err <= x"05"; 
        wait for clk_period * 2; 
        ctr_err <= x"f6"; 
        wait for clk_period * 2; 
        ctr_err <= x"d8"; 

        wait; 
    end process;

end bhv;