library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity stw_tb is 
end entity; 


architecture bhv of stw_tb is 
    component stw is 
        PORT(--start : in STD_LOGIC; 
         reset : in STD_LOGIC; 
         --resum : in STD_LOGIC; 
         clk : in STD_LOGIC; 
         h_tick, m_tick, s_tick : out STD_LOGIC_VECTOR(5 downto 0); 
         mili_s : out STD_LOGIC_VECTOR(6 downto 0)); 
    end component; 
    signal reset, clk : std_logic := '0';
    signal h_tick, m_tick, s_tick : std_logic_vector(5 downto 0) := (others => '0'); 
    signal mili_s : std_logic_vector(6 downto 0) := (others => '0'); 

    constant clk_periode : time := 10 ns; 

begin 

    --clock generation 100Mhz 
    clk_p : process
    begin 
        clk <= '0'; 
        wait for clk_periode/2; 
        clk <= '1'; 
        wait for clk_periode/2; 
    end process clk_p; 

    uut : stw
        port map( reset => reset, 
                  clk => clk, 
                  h_tick => h_tick, 
                  m_tick => m_tick,
                  s_tick => s_tick, 
                  mili_s => mili_s); 

    stim_p : process 
    begin 
        reset <= '0'; 
        wait for 20 ms;
        reset <= '1'; 
        wait for 1 ms; 
        reset <= '0'; 



        wait; 
    end process stim_p; 







end bhv; 