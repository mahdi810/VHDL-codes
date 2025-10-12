----------------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi

-- Create Date: 06/03/2025 11:49:47 AM
-- Module Name: spicpol0cph1 - Behavioral
-- Description: SPI transmitter top level file cpol=0, cphase = 1, 8bit. 
                --BTND (reset) => reset the state machine 
                --BTNC (start) => start the transmission 
                --input Data (sndData) => assign data to be send ( from switches) 
                --output Data (rcvData) => received data ( to the LEDs) 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity spitop_tb is
--  Port ( );
end spitop_tb;

architecture Behavioral of spitop_tb is
component spitop is
    Port ( reset : in STD_LOGIC;
           bclk : in STD_LOGIC;
           start : in STD_LOGIC;
           sndData : in STD_LOGIC_VECTOR (7 downto 0);
           rcvData : out STD_LOGIC_VECTOR (7 downto 0));
end component spitop;
signal reset, bclk, start : std_logic := '0'; 
signal sndData : std_logic_vector(7 downto 0) := x"A5"; 
signal rcvData : std_logic_vector(7 downto 0) := x"00"; 
constant clk_period : time := 10 ns; 

begin
    uut : spitop 
        port map( reset   =>  reset  ,
                  bclk    =>  bclk   ,
                  start   =>  start ,
                  sndData =>  sndData,
                  rcvData =>  rcvData);
                  
     clk_p : process 
        begin 
            bclk <= '0'; 
            wait for clk_period/2; 
            bclk <= '1'; 
            wait for clk_period/2; 
        end process clk_p; 
        
     stim_p : process 
        begin 
            wait for clk_period; 
            reset <= '1'; 
            wait for clk_period;
            reset <= '0';  
            wait for clk_period; 
            start <= '1'; 
            wait for clk_period; 
            start <= '0'; 
            wait for clk_period; 
            wait; 
        end process stim_p; 

end Behavioral;
