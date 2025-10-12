-------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi
-- Create Date: 06/03/2025 11:49:47 AM
-- Module Name: spicpol0cph1 – Behavioral – top level file
-- Description: SPI transmitter cpol=0, cphase = 1, 8bit.
-------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity spitop is
    Port (
        reset   : in  STD_LOGIC;
        start   : in  STD_LOGIC;
        bclk    : in  STD_LOGIC;
        sndData : in  STD_LOGIC_VECTOR (7 downto 0);
        rcvData : out STD_LOGIC_VECTOR (7 downto 0)
    );
end spitop;

architecture Behavioral of spitop is
    component spicpol0chp1 is
        Port (
            reset   : in  STD_LOGIC;
            bclk    : in  STD_LOGIC;
            start   : in  STD_LOGIC;
            done    : out STD_LOGIC;
            scsq    : out STD_LOGIC;
            sclk    : out STD_LOGIC;
            sdi     : in  STD_LOGIC;
            sdo     : out STD_LOGIC;
            sndData : in  STD_LOGIC_VECTOR (7 downto 0);
            rcvData : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component spicpol0chp1;

    signal done  : STD_LOGIC;
    signal scsq  : STD_LOGIC;
    signal sclk  : STD_LOGIC;
    signal sdi   : STD_LOGIC;
    signal sdo   : STD_LOGIC;

begin
    sdi <= not sdo;

    spi8 : spicpol0chp1
        port map (
            reset   => reset,
            bclk    => bclk,
            start   => start,
            done    => done,
            scsq    => scsq,
            sclk    => sclk,
            sdi     => sdi,
            sdo     => sdo,
            sndData => sndData,
            rcvData => rcvData
        );
end Behavioral;