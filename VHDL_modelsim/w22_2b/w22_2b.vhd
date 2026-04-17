library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity w22_2b is 
    port(
        clk : in std_logic; 
        b : in std_logic_vector(1 downto 0); 
        y : out std_logic
    ); 
end w22_2b;

architecture bhv of w22_2b is 
    type state_type is (st0, st1, st2, st3); 
    signal state, next_state : state_type; 
begin 

    --sequential process 
    seq_p : process(clk)
    begin 
        if rising_edge(clk) then 
            state <= next_state; 
        end if; 
    end process seq_p; 

    --combinational process 
    comb_p : Process(state, b)
    begin 
        --default values cases 
        next_state <= state; 
        y <= '0'; 
        case state is 
            when st0 =>
                y <= '0'; 
                if b = "11" then 
                    next_state <= st1; 
                elsif b = "10" then 
                    next_state <= st2; 
                end if;   
            when st1 => 
                y <= '0'; 
                if b = "11" then 
                    next_state <= st2; 
                end if; 
            when st2 => 
                y <= '1'; 
                if b = "11" then 
                    next_state <= st3; 
                elsif b = "10" then 
                    next_state <= st0; 
                end if; 
            when st3 => 
                y <= '1'; 
                next_state <= st0; 
        end case; 
    end process comb_p; 


end bhv; 

