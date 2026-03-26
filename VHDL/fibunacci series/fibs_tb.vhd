library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fibs_tb is
end fibs_tb;
-- it is not complete yet. the program is not working fine right now, but I will fix it later.



architecture behavioral of fibs_tb is 
    component fibs is 
        port(
            clk : in std_logic; 
            reset : in std_logic; 
            start : in std_logic; 
            done : out std_logic; 
            n : in unsigned(7 downto 0); 
            y_out : out unsigned(7 downto 0)
        );
    end component fibs; 
    signal reset : std_logic := '0';
    signal start : std_logic := '0';
    signal done : std_logic;
    signal n : unsigned(7 downto 0) := (others => '0');
    signal y_out : unsigned(7 downto 0);

    constant clk_period : time := 10 ns;
    signal clk : std_logic := '0';
begin
    
    --clock generation process; 
    clk_p : process
    begin 
        clk <= '0'; 
        wait for clk_period/2; 
        clk <= '1'; 
        wait for clk_period/2; 
    end process;

    --instantiation of the fibs component; 
    uut : entity work.fibs
        port map(
            clk => clk, 
            reset => reset, 
            start => start, 
            done => done, 
            n => n, 
            y_out => y_out
        );

    --stimulus process to test the fibs component;
    stim_p : process 
    begin 
        start <= '0'; 
        reset <= '1'; 
        n <= x"14";
        wait for clk_period * 5; 
        start <= '1'; 
        reset <= '0'; 
        wait for clk_period * 20;  
    wait; 
    end process stim_p;

    


end behavioral; 