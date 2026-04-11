library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity led_fsm is 
    port(
        clk, reset : in std_logic; 
        b0 : in std_logic; 
        L : out std_logic_vector(2 downto 0)
    ); 
end entity; 

architecture bhv of led_fsm is 
    type state_type is (state0, state1, state2, state3, state4, state5, state6, state7); 
    signal state, next_state : state_type; 

begin 

    --suquential process 
    seq_p : process(clk, reset)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= state0; 
            else 
                state <= next_state; 
            end if; 
        end if; 
    end process seq_p; 

    --combination process for finding th next_state; 
    comb_p : process(state, b0)
    begin 
        --default values; 
        next_state <= state; 
        L <= (others => '0'); 
        case state is 
            when state0 =>
                L <= "000"; 
                if b0 = '0' then 
                    next_state <= state1; 
                end if;   
            when state1 =>
                L <= "001"; 
                if b0 = '0' then 
                    next_state <= state2; 
                elsif b0 = '1' then 
                    next_state <= state0; 
                end if;   
            when state2 =>
                L <= "010"; 
                if b0 = '0' then 
                    next_state <= state3; 
                elsif b0 = '1' then 
                    next_state <= state0; 
                end if;   
            when state3 =>
                L <= "011"; 
                if b0 = '0' then 
                    next_state <= state4; 
                elsif b0 = '1' then 
                    next_state <= state0; 
                end if;   
            when state4 =>
                L <= "100"; 
                if b0 = '0' then 
                    next_state <= state5; 
                elsif b0 = '1' then 
                    next_state <= state0; 
                end if;   
            when state5 =>  
                L <= "101"; 
                if b0 = '0' then 
                    next_state <= state6; 
                elsif b0 = '1' then 
                    next_state <= state0; 
                end if; 
            when state6 =>
                L <= "110"; 
                if b0 = '0' then 
                    next_state <= state7; 
                elsif b0 = '1' then 
                    next_state <= state0; 
                end if;  
            when state7 =>
                L <= "111"; 
                if b0 = '1' then 
                    next_state <= state0; 
                end if;  
        end case; 
    end process comb_p; 

end bhv; 