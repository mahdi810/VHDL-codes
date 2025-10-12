library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fib is 
    port( clk, reset, start : in std_logic; 
          y_out : out unsigned(31 downto 0); 
          n : in integer );
end entity; 


architecture bhv of fib is 
    type type_state is (idle, st1, st2);
    signal  state, next_state: type_state; 
    signal r1, r1_next, r2, r2_next : unsigned(31 downto 0) := (others => '0'); 
    signal n_i, n_i_next : integer := 0; 
begin 
    
    --sequential process
    seq_p : process(clk, reset)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                r1 <= (others => '0'); 
                r2 <= (others => '0');
                n_i <= 0;  
            else 
                r1 <= r1_next; 
                r2 <= r2_next; 
                n_i <= n_i_next; 
            end if; 
        end if; 
    end process seq_p; 

    --combinational process
    comb_p : process(state, next_state, r1, r1_next, r2, r2_next, start, n_i, n_i_next)
    begin 
        --default values 
        next_state <= state; 
        r1_next <= r1; 
        r2_next <= r2; 
        n_i_next <= n_i;    
            case state is 
                when idle => 
                    r1_next <= (others => '0'); 
                    r2_next <= (others => '0'); 
                    n_i_next <= n-2; 
                    if start = '1' then 
                        next_state <= st1; 
                    else 
                        next_state <= idle; 
                    end if; 
                when st1 => 
                    r2_next <= r1 + r2; 
                    r1_next <= r1; 
                    n_i_next <= n_i - 1; 
                    next_state <= st2; 
                when st2 => 
                    r2_next <= r1 + r2; 
                    r1_next <= r1; 
                    n_i_next <= n_i - 1; 
                    next_state <= st2; 
                    if n_i = 0 then 
                        next_state <= idle; 
                    else 
                        next_state <= st1; 
                    end if; 
            end case; 
    end process comb_p; 
    y_out <= r2_next; 
end bhv; 