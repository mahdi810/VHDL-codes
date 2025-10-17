--Engineer : Mohammad Mahdi Mohammadi 
--this circuit uses time multiplexing to reduce the number of bit required for displaying the four 7 segement displays. 
--it uses high frequency to turn each of the 7 segment display and make the illusion that all of them are on at the same time. 

LIBRARY  IEEE; 
USE IEEE.std_logic_1164.ALL; 
USE IEEE.numeric_std.ALL; 

ENTITY LED_tm is 
    port (in0, in1, in2,in3 : in STD_LOGIC_VECTOR(7 downto 0); 
          enable : in STD_LOGIC; 
          reset : in STD_LOGIC;
          clk : in STD_LOGIC;  
          sseg : out STD_LOGIC_VECTOR( 7 downto 0); 
          an : out STD_LOGIC_VECTOR(3 downto 0) ); 
END ENTITY; 


ARCHITECTURE bhv of LED_tm is 
    type state_type is (idle, st0, st1, st2, st3); 
    SIGNAL state, next_state : state_type; 
    SIGNAL clk_out : STD_LOGIC := '0'; 
    CONSTANT max_count : integer := 49999; --for an output frequency of 1000Hz 
    SUBTYPE counter_type IS INTEGER RANGE 0 TO max_count; 

BEGIN 

    --clock division
    clk_div : PROCESS(clk)
    VARIABLE cnt : counter_type := 0; 
    BEGIN 
        IF RISING_EDGE(clk) THEN 
            IF reset = '1' THEN 
                cnt := 0; 
                clk_out <= '0';
            ELSE 
                IF cnt = max_count THEN 
                    cnt := 0; 
                    clk_out <= NOT clk_out; 
                ELSE 
                    cnt := cnt + 1; 
                END IF; 
            END IF; 
        END IF; 
    END PROCESS clk_div; 


    --here the clock should be at least 1000Hz and the high frequency clock of the fpga should not be USEd.
    --the clock should be divided and THEN USEd. 
    --sequential PROCESS 
    seq_p : PROCESS(clk_out, reset)
    BEGIN 
        IF rising_edge(clk_out) THEN 
            IF reset = '1' THEN 
                state <= idle; 
            ELSE 
                state <= next_state; 
            END IF; 
        END IF; 
    END PROCESS seq_p;
    
    --combinational PROCESS
    comb_p : PROCESS(enable, state)
    BEGIN 
        --defaults 
        next_state <= state; 
        CASE state is 
            WHEN idle => 
                sseg <= (others => '0'); 
                an <= (others => '0');
                IF enable = '1' THEN 
                    next_state <= st0; 
                END IF;  
            WHEN st0 => 
                sseg <= in0; 
                an <= "1110"; 
                next_state <= st1; 
            WHEN st1 => 
                sseg <= in1; 
                an <= "1101"; 
                next_state <= st2; 
            WHEN st2 => 
                sseg <= in2; 
                an <= "1011"; 
                next_state <= st3; 
            WHEN st3 => 
                sseg <= in3; 
                an <= "0111"; 
                IF enable = '1' THEN 
                    next_state <= st0; 
                ELSE 
                    next_state <= idle; 
                END IF; 
        END CASE; 
    END PROCESS comb_p; 
END bhv; 