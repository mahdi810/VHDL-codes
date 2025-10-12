----------------------------------------------------------------------------------
-- Engineer: Mohammad Mahdi Mohammadi  

-- Create Date: 06/03/2025 11:49:47 AM
-- Module Name: spicpol0cph1 - Behavioral
-- Description: SPI transmitter cpol=0, cphase = 1, 8bit. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity spicpol0cph1 is
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
end spicpol0cph1;

architecture Behavioral of spicpol0cph1 is
constant SPI_NBITS : integer := 8; 
TYPE State_type is (sidle, sstartx, sstart_lo, sclk_hi, sclk_lo, sstop_hi, sstop_lo); 

SIGNAL state, next_state : State_type; 
SIGNAL scsq_i, sclk_i, sdo_i : std_logic; 
SIGNAL start_i: std_logic; 
SIGNAL wr_buf : std_logic_vector(SPI_NBITS-1 downto 0); 
SIGNAL rd_buf : std_logic_vector(SPI_NBITS-1 downto 0); 
SIGNAL count : integer range 0 to SPI_NBITS-1; 

begin
    rcvData <= rd_buf; 
    
    seq_p : process(bclk)
        begin 
        if rising_edge(bclk) then 
            start_i <= start; 
            if reset = '1' then 
                state <= sidle;     
                scsq <= '1'; 
                sclk <= '0'; 
                sdo <= '0'; 
             else 
                if next_state = sstartx then 
                    count <= SPI_NBITS -1; 
                    wr_buf <= sndData; 
                elsif next_state = sclk_hi then 
                    count <= count -1; 
                end if; 
                
                state <= next_state;
                scsq <= scsq_i;  
                sclk <= sclk_i; 
                sdo <= sdo_i; 
             end if; 
        end if; 
                
        end process seq_p; 
        
     cmb_p : process(state, start_i)
        begin 
        next_state <= state; 
        scsq_i <= '0'; 
        sclk_i <= '0'; 
        sdo_i <= '0'; 
        done <= '0'; 
        
        case state is 
            when sidle => 
                done <= '1'; 
                scsq_i <='1';
                if start_i = '1' then 
                    next_state <= sstartx; 
                end if; 
            when sstartx => 
                next_state <= sstart_lo; 
            
            when sstart_lo => 
                next_state <= sclk_hi; 
                sclk_i <= '1'; 
                sdo_i <= wr_buf(SPI_NBITS-1); 
            
            when sclk_hi => 
                next_state <= sclk_lo; 
                sdo_i <= wr_buf(SPI_NBITS -1);                        
            when sclk_lo => 
                sclk_i <= '1'; 
                if count = 0 then 
                    next_state <= sstop_hi; 
                else 
                    next_state <= sclk_hi; 
                end if;            
            when sstop_hi => 
                next_state <= sstop_lo; 
                sdo_i <= wr_buf(SPI_NBITS -1);  
            when sstop_lo => 
                next_state <= sidle; 
                scsq_i <= '1';      
        end case;
        end process cmb_p; 

end Behavioral;














