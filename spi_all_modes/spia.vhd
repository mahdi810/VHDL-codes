--this program simulates the master spi
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity spia is 
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
end entity; 

architecture bhv of spia is 
    signal count : integer := 0; 
    signal wr_buf : std_logic_vector(nn-1 downto 0) := (others => '0'); 
    signal rd_buf : std_logic_vector(nn-1 downto 0) := (others => '0'); 
    signal sdo_i : std_logic;
    signal sclk_i, start_i, scsq_i : std_logic := '0';

    TYPE state_type IS (idle, sstart_x, sstart_lo, sclk_hi, sclk_lo, sstop_hi, sstop_lo); 
    SIGNAL pr_state, next_state : state_type; 

    SIGNAL clk_d : STD_LOGIC := '0'; 
    CONSTANT max_count : INTEGER := 5; 
    SUBTYPE counter_type IS INTEGER RANGE 0 TO max_count; 
begin 

    --clock division by using another mehtods, it has a property that the on and off time of the clock is the same lenght.
    clk_div : PROCESS(bclk, reset)
    VARIABLE cnt: counter_type := max_count; 
    BEGIN 
        IF RISING_EDGE(bclk) THEN 
            start_i <= start; 
            IF reset = '1' THEN 
                clk_d <= '0';
                cnt := 0; 
            ELSE 
                IF cnt = 0 THEN 
                clk_d <= NOT clk_d; 
                cnt := max_count; 
                ELSE 
                cnt := cnt - 1; 
                END IF; 
            END IF; 
        END IF; 
    END PROCESS clk_div; 



    rcvData <= rd_buf; 

    --sequential process 
    seq_p : PROCESS(clk_d, reset)
    BEGIN 
        IF RISING_EDGE(clk_d) THEN 
            start_i <= start; 
                IF reset = '1' THEN 
                    pr_state <= idle; 
                    sclk <= '0'; 
                    sdo <= '0'; 
                ELSE 
                    IF next_state = sstart_x THEN 
                        count <= nn - 1; 
                        wr_buf <= sndData; 
                    ELSIF next_state = sclk_hi THEN 
                        count <= count - 1; 
                    ELSIF next_state = sclk_lo THEN 
                        wr_buf <= wr_buf(nn-1 downto 0) & '-'; 
                        rd_buf <= rd_buf(nn-1 downto 0) & sdi; 
                    END IF; 
                    pr_state <= next_state; 
                    sclk <= sclk_i; 
                    sdo <= sdo_i; 
                    scsq <= scsq_i; 
                END IF; 
        END IF; 
    END PROCESS seq_p; 

    --combinational process 
    comb_p : PROCESS(start, pr_state, sdi, wr_buf, rd_buf)
    BEGIN 
        --default values 
        sclk <= '0'; 
        next_state <= pr_state;
        sdo <= '0'; 
        scsq_i <= '1'; 
        done <= '0'; 
        CASE pr_state IS 
            WHEN idle       => 
                done <= '1'; 
                scsq_i <= '1'; 
                IF start_i = '1' THEN 
                    next_state <= sstart_x; 
                END IF; 
            WHEN sstart_x   => 
                next_state <= sstart_lo; 
            WHEN sstart_lo  => 
                sclk_i <= '1'; 
                sdo_i <= wr_buf(nn - 1); 
                next_state <= sclk_hi; 
            WHEN sclk_hi    => 
                sdo_i <= wr_buf(nn-1); 
                next_state <= sclk_lo; 
            WHEN sclk_lo    => 
                sclk_i <= '1'; 
                sdo_i <= wr_buf(nn-1); 
                IF count = 0 THEN 
                    next_state <= sstop_hi;
                ELSE 
                    next_state <= sclk_hi; 
                END IF;  
            WHEN sstop_hi   => 
                sdo_i <= wr_buf(nn-1);
                next_state <= sstop_lo;  
            WHEN sstop_lo   => 
                scsq_i <= '1'; 
                next_state <= idle; 
        END CASE; 
    END PROCESS comb_p; 


end bhv; 
