LIBRARY IEEE; 
USE IEEE.std_logic_1164.all; 
USE IEEE.NUMERIC_STD.ALL; 

ENTITY spia_tb IS 
END ENTITY; 

ARCHITECTURE bhv OF spia_tb IS 
    COMPONENT spia IS 
        generic (nn : integer := 8); 
        port (reset     : in std_logic; 
            bclk      : in std_logic; 
            sclk      : out std_logic; 
            start     : in std_logic; 
            done      : out std_logic; 
            scsq      : out std_logic; 
            sdi       : in std_logic; 
            sdo       : out std_logic;  
            sndData    : in std_logic_vector(nn-1 downto 0); --data to be sent out 
            rcvData   : out std_logic_vector(nn-1 downto 0));  --data that has been received 
    END COMPONENT spia; 
    CONSTANT nn : INTEGER := 8; 
    SIGNAL reset, bclk, sclk, start, done, scsq, sdi, sdo : STD_LOGIC := '0'; 
    SIGNAL sndData, rcvData : STD_LOGIC_VECTOR(nn-1 DOWNTO 0) := (OTHERS =>  '0'); 
    CONSTANT clk_periode : TIME := 10 ns; 

BEGIN 

    --clock generation 
    clk_p : PROCESS 
    BEGIN 
        bclk <= '0'; 
        WAIT FOR clk_periode/2; 
        bclk <= '1'; 
        WAIT FOR clk_periode/2; 
    END PROCESS clk_p; 

    uut : spia 
        PORT MAP( reset => reset, 
                  bclk => bclk, 
                  sclk => sclk, 
                  start => start, 
                  done => done, 
                  scsq => scsq, 
                  sdi => sdi, 
                  sdo => sdo, 
                  sndData => sndData, 
                  rcvData => rcvData );
                  
    stim_p : PROCESS 
    BEGIN 
        reset <= '1';
        start <= '0'; 
        sndData <= x"0A"; 
        WAIT FOR clk_periode; 
        reset <= '0'; 
        start <= '1'; 
        WAIT FOR clk_periode*800; 



        WAIT; 
    END PROCESS stim_p; 

END bhv; 