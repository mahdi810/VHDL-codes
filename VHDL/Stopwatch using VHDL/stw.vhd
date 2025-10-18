LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 

ENTITY stw IS 
    PORT(--start : in STD_LOGIC; 
         reset : in STD_LOGIC; 
         --resum : in STD_LOGIC; 
         clk : in STD_LOGIC; 
         h_tick, m_tick, s_tick : out STD_LOGIC_VECTOR(5 downto 0); 
         mili_s : out STD_LOGIC_VECTOR(6 downto 0)); 
END ENTITY; 

ARCHITECTURE bhv OF stw IS 
    
    --CONSTANT max_count1 : integer := 499_999; --for clock division.
    CONSTANT max_count1 : integer := 1; --for clock division.
    CONSTANT max_count2 : integer := 100;       --for mod 100 counter. 
    SUBTYPE counter_type1 IS integer RANGE 0 TO max_count1; 
    SUBTYPE counter_type2 IS integer RANGE 0 TO 60; 
    SIGNAL clk_out : STD_LOGIC := '0'; --100 Hz clock derived from the 100MHz 
    SIGNAL h_ticki, m_ticki, s_ticki : counter_type2 := 0; 
    SIGNAL mili_si : counter_type1 := 0; 
BEGIN

    --the following process divides the clock into 100hz to run the milisecond counter. 
    --clock division process 
    clk_div : PROCESS(clk)
    VARIABLE cnt1 : counter_type1 := 0; 
    BEGIN 
        IF RISING_EDGE(clk) THEN 
            IF reset = '1' THEN 
                clk_out <= '0'; 
                cnt1 := 0; 
            ELSE 
                IF cnt1 = max_count1 THEN 
                    clk_out <= NOT clk_out; 
                    cnt1 := 0; 
                ELSE 
                    cnt1 := cnt1 + 1; 
                END IF; 
            END IF; 
        END IF; 
    END PROCESS clk_div; 


    --mode 100 counter with 100Hz frequency 
    m100_counter : PROCESS(clk_out)
    BEGIN 
        IF RISING_EDGE(clk_out) THEN 
            IF reset = '1' THEN 
                mili_si <= 0; 
            ELSE 
                IF mili_si = 99 THEN 
                    mili_si <= 0;
                ELSE 
                    mili_si <= mili_si + 1; 
                END IF; 
            END IF; 
        END IF; 
    END PROCESS m100_counter; 
    

    
    --second hand movement 
    sec_hand : PROCESS(mili_si, reset)
    VARIABLE sec_count : counter_type2 := 0; 
    BEGIN 
        IF reset = '1' THEN 
            s_ticki <= 0; 
            m_ticki <= 0; 
            h_ticki <= 0; 
        ELSE 
            IF mili_si = 0 THEN 
                s_ticki <= s_ticki + 1; 
                IF s_ticki = 59 THEN 
                    s_ticki <= 0; 
                    m_ticki <= m_ticki + 1; 
                    IF m_ticki = 59 THEN 
                        m_ticki <= 0; 
                        h_ticki <= h_ticki + 1; 
                        IF h_ticki = 23 THEN 
                            h_ticki <= 0;
                        END IF; 
                    END IF; 
                END IF; 
            END IF; 
        END IF; 
    END PROCESS sec_hand; 

    mili_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(mili_si, mili_s'LENGTH)); 
    s_tick <= STD_LOGIC_VECTOR(TO_UNSIGNED(s_ticki, s_tick'LENGTH)); 
    m_tick <= STD_LOGIC_VECTOR(TO_UNSIGNED(m_ticki, m_tick'LENGTH)); 
    h_tick <= STD_LOGIC_VECTOR(TO_UNSIGNED(h_ticki, h_tick'LENGTH)); 


END bhv; 