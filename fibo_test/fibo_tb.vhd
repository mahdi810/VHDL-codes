library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fibo_tb is 
end fibo_tb; 

architecture rtl of fibo_tb is 

    component fibo is 
        port( clk : in std_logic; 
              reset : in std_logic; 
              n : in integer ; 
              u_out : out unsigned(31 downto 0); 
              done : out std_logic; 
              start : in std_logic ); 
    end component fibo; 

    signal clk, reset, done, start : std_logic :=  '0'; 
    signal n : integer :=  0; 
    signal u_out : unsigned(31 downto 0) := (others => '0'); 

    constant clk_periode : time :=  10 ns; 

begin 

    -- Clock generation 
    clk_p : process 
    begin 
        clk <= '0'; 
        wait for clk_periode/2; 
        clk <= '1'; 
        wait for clk_periode/2;
    end process clk_p; 

    -- DUT instantiation
    uut : fibo
        port map( clk =>  clk, 
                  reset => reset, 
                  n => n, 
                  u_out => u_out, 
                  done => done, 
                  start => start ); 

    -- Stimulus process
    stim_p : process
    begin 
        -- Initialize and start Fibonacci calculation
        n <= 15; 
        reset <= '1'; 
        start <= '0'; 
        wait for clk_periode * 2;
        reset <= '0'; 
        start <= '1'; 
        wait for clk_periode * 20; 
        -- Assert reset to finish simulation
        reset <= '1'; 
        start <= '0'; 
        wait for clk_periode; 
        wait; 
    end process stim_p; 
end rtl;