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


entity spitop is
    Port ( reset : in STD_LOGIC;
           bclk : in STD_LOGIC;
           start : in STD_LOGIC;
           sndData : in STD_LOGIC_VECTOR (7 downto 0);
           rcvData : out STD_LOGIC_VECTOR (7 downto 0));
end spitop;

architecture Behavioral of spitop is
component spicpol0cph1 is
    Port ( reset : in STD_LOGIC;
           bclk : in STD_LOGIC;
           start : in STD_LOGIC;
           done : out STD_LOGIC;
           scsq : out STD_LOGIC;
           sclk : out STD_LOGIC;
           sdi : in STD_LOGIC;
           sdo : out STD_LOGIC;
           sndData : in STD_LOGIC_VECTOR (7 downto 0);
           rcvData : out STD_LOGIC_VECTOR (7 downto 0));
end component spicpol0cph1; 

signal done, scsq, sclk, sdi, sdo : std_logic; 

begin

    sdi <= NOT sdo; 
    spi8 : spicpol0cph1
        port map(  reset =>   reset,
                   bclk =>    bclk,
                   start =>   start,
                   done =>    done ,
                   scsq =>    scsq ,
                   sclk =>    sclk ,
                   sdi =>     sdi ,
                   sdo =>     sdo ,
                   sndData =>  sndData,
                   rcvData =>  rcvData);



end Behavioral;
