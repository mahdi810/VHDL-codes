library ieee; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 

ENTITY tlcsimple is  
    PORT( 
            treset : in STD_LOGIC; 
            tclk : in STD_LOGIC;
            normal_operation : in STD_LOGIC; 
            night_operation : in STD_LOGIC; 
            red : out STD_LOGIC; 
            green : out STD_LOGIC; 
            amber : out STD_LOGIC
            
    );

END entity; 

architecture behavioural of tlcsimple is 
    TYPE State_type is (st_red, st_ra, st_gr, st_am, st_off, st_xam); 
    SIGNAL state, next_state : State_type; 

    BEGIN 

    seq_p : PROCESS 
    BEGIN 
        IF RISING_EDGE(tclk) THEN 
            IF treset = '1' THEN 
                state <= st_red; 
            ELSE 
                state <= next_state; 
            END IF; 
        END if;    
    END PROCESS seq_p; 
        
    comb_p : PROCESS 
    
    BEGIN 
        CASE state IS 
            WHEN st_red => 
                red <= '1'; 
                IF normal_operation = '1' THEN 
                    next_state <= st_ra;
                ELSIF night_operation = '1' THEN 
                    next_state <= st_off; 
                END IF ; 
            WHEN st_ra   => 
                red <= '1'; 
                amber <= '1'; 
                next_state <= st_gr; 
            WHEN st_gr =>
                green <= '1';  
                next_state <= st_am; 
            WHEN st_am => 
                amber <= '1'; 
                next_state <= st_red; 
            WHEN st_off => 
                IF night_operation = '1' THEN 
                    next_state <= st_xam; 
                ELSE 
                    next_state <= st_red; 
                END IF ;  
            WHEN st_xam => 
                amber <= '1'; 
                next_state <= st_off; 
        END CASE ; 

    END PROCESS comb_p; 

END behavioural; 