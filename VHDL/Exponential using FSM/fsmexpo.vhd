library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
entity fsmexpo is 
    port( clk   : in std_logic; 
          reset : in std_logic; 
          start : in std_logic; 
          done  : out std_logic; 
          e_in  : in std_logic_vector(15 downto 0); 
          u_out : out std_logic_vector(15 downto 0) );
end fsmexpo; 

architecture bhv of fsmexpo is 
    type state_type is (idle, init, itera1, itera2, iterb1, iterb2, final); 
    signal state, next_state : state_type; 
    constant fract : integer := 9; 
    subtype int16_t is integer range -32768 to 32767; 
    subtype counter_type is integer range 0 to 7; 
    signal k : counter_type :=  0; 

    signal ee_in, uu_out : int16_t;
    signal temp : int16_t;  
    signal x0, y0, z0 : int16_t; 
    
begin 

    seq_p : process(clk, reset)
    variable cnt : counter_type := 0; 
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <=  idle; 
            else 
                state <=  next_state; 
            end if; 
        end if; 
    end process seq_p; 

    comb_p : process(start)
    begin 
        ee_in <= to_integer(signed(e_in)) ; 
        case state is 
            when idle =>  
                if start = '1' then 
                    next_state <=  init; 
                else 
                    next_state <= idle; 
                end if; 
            when init =>  
                x0 <=  1 - ee_in/2; 
                y0 <=  1 + ee_in/2; 
                z0 <=  0; 
                if y0 > 0 then 
                    next_state <=  itera1; 
                else 
                    next_state <=  iterb1; 
                end if; 

            when itera1 => 
                y0 <=  y0 + x0/2**k;
                z0 <=  z0 - 1/2**k; 
                x0 <=  x0 + y0/2**k; 
                k <=  k + 1; 
                if y0 > 0 then 
                    next_state <= itera2; 
                else 
                    next_state <= iterb2; 
                end if;  
            when itera2 =>  
                y0 <=  y0 + x0/2**k;
                z0 <=  z0 - 1/2**k; 
                x0 <=  x0 + y0/2**k; 
                k <=  k + 1; 
                if k /= 7 then 
                    if y0 > 0 then 
                        next_state <= itera1; 
                    else 
                        next_state <= iterb2; 
                    end if; 
                else 
                    next_state <= final; 
                end if; 
            when iterb1 =>  
                y0 <=  y0 - x0/2**k;
                z0 <=  z0 + 1/2**k; 
                x0 <=  x0 - y0/2**k; 
                k <=  k + 1; 
                if y0 > 0 then 
                    next_state <= itera2; 
                else 
                    next_state <= iterb2; 
                end if; 
            when iterb2 => 
                y0 <=  y0 - x0/2**k;
                z0 <=  z0 + 1/2**k; 
                x0 <=  x0 - y0/2**k; 
                k <=  k + 1; 
                if k /= 7 then 
                    if y0 > 0 then 
                        next_state <= itera1; 
                    else 
                        next_state <= iterb1; 
                    end if; 
                else 
                    next_state <= final; 
                end if; 
            when final => 
                temp <=  z0; 
                done <= '1'; 
                next_state <=  idle; 
        end case; 
    end process comb_p; 
end bhv; 