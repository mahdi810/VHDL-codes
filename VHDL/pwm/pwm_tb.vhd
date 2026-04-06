library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_tb is

end pwm_tb;

architecture bhv of pwm_tb is
    component pwm is
        generic(NBIT : integer := 12); 
        port (
            clk : in std_logic;
            pval : in std_logic_vector(11 downto 0);
            pwmout : out std_logic
        );
    end component pwm;
    constant NBIT : integer := 12; 
    signal clk, pwmout : std_logic := '0';
    signal pval : std_logic_vector(NBIT -1  downto 0) := (others => '0');
    constant clk_period : time := 10 ns;

begin

    --clock generation 
    clk <= not clk after clk_period/2;

    --unit under test 
    uut : entity work.pwm
        generic map(NBIT => NBIT)
        port map(
            clk => clk,
            pval => pval,
            pwmout => pwmout
        ); 

        --stimulus process 
        stim_p : process 
        begin 
            pval <= x"555"; 
            wait for clk_period * 10; 


        wait; 
        end process stim_p; 

end bhv;