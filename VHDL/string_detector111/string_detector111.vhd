library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity string_detector111 is
    port (
        clk : in std_logic;
        reset : in std_logic;
        d : in std_logic; 
        q : out std_logic); --output 
end string_detector111;

architecture behavioral of string_detector111 is
    type state_type is (zero, one, two, three);
    signal state, next_state : state_type;   
begin

    --sequential process 
    seq_p : process(clk, reset)
    begin 
        if reset = '1' then 
            state <= zero; 
        else 
            if (clk'event AND clk = '1') then 
                state <= next_state; 
            end if; 
        end if; 
    end process seq_p; 

    --combination process 
    comb_p : process(state, d)
    begin 
        -- next_state <= state; 
            case state is 
                when zero  => 
                    q <= '0'; 
                    if (d = '1') then 
                        next_state <= one; 
                    else 
                        next_state <= zero; 
                    end if; 
                when one => 
                    q <= '0'; 
                    if (d = '1') then 
                        next_state <= two; 
                    else 
                        next_state <= zero; 
                    end if; 
                when two => 
                    q <= '0'; 
                    if d = '1' then 
                        next_state <= three; 
                    else 
                        next_state <= zero; 
                    end if; 
                when three =>
                    q <= '1'; 
                    if d = '1'  then 
                        next_state <= three; 
                    else 
                        next_state <= zero; 
                    end if;  
            end case; 
    end process comb_p; 

end behavioral;