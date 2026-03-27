--this program implement the fibunacci series using finite state machines. 

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fib2 is 
    port(
        clk, reset, start   : in std_logic; 
        s_num               : in integer; 
        y_out               : out integer; 
        done                : out std_logic
    ); 
end fib2; 

architecture behavioral of fib2 is 
    type state_type is (idle,s_start, s_run, s_stop); 
    signal state : state_type := idle; 
    signal next_state : state_type;
    
    subtype int16_t is integer range -32768 to 32767; 
    signal y_out_reg, y_out_reg2, y_out1, y_out2 : int16_t := 0; 
    signal count, count_reg : integer := 0; 
begin 

    --sequential process 
    seq_p : process(clk, reset)
    begin 
        if (clk'event AND clk = '1') then 
            if reset = '1' then 
                state <= idle;
                y_out_reg <= 0;  
                y_out_reg2 <= 0; 
                count_reg <= 0; 
            else 
                state <= next_state; 
                y_out_reg <= y_out1;
                y_out_reg2 <= y_out2;  
                count_reg <= count;
            end if; 
        end if; 
    end process seq_p; 

    --combination process 
    comb_p : process(state, s_num, start, y_out_reg, y_out_reg2, count_reg, count)
    begin 
        --default values 
        next_state <= state; 
        y_out1 <= 0;
        y_out2 <= 0; 
        done <= '0';
            case state is 
                when  idle => 
                    y_out1 <= 0; 
                    y_out2 <= 0;
                    done <= '1';  
                    if start = '1' then 
                        next_state <= s_start; 
                    end if; 
                when s_start => 
                    y_out1 <= 0; 
                    y_out2 <= 1; 
                    count <= s_num; 
                    next_state <= s_run;  
                when s_run =>  
                    if count > 0 then 
                        y_out2 <= y_out_reg + y_out_reg2;
                        y_out1 <= y_out_reg2; 
                        count <= count_reg - 1; 
                    end if; 

                    if count = 0 then 
                        next_state <= s_stop; 
                    end if; 
                when s_stop => 
                    next_state <= idle; 
            end case; 
    end process comb_p; 

    y_out <= y_out2; 

end behavioral; 