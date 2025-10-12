-- Engineer : Mohammad Mahdi Mohammadi 
--This program compute the exp(u_in) = (1 +u/2)/(1 - u/2) based on the repetative iteration method, which is an approximation method. ; 

library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 

entity fsmexp is 
    port( u_in  : in std_logic_vector(15 downto 0); 
          u_out : out std_logic_vector(15 downto 0); 
          clk   : in std_logic; 
          start : in std_logic; 
          reset : in std_logic; 
          done  : out std_logic ); 
end fsmexp; 

architecture behavioural of fsmexp is 
    type my_state is (idle, init, iter, final); 
    signal state, next_state : my_state; 
    subtype int16_t is integer range -32768 to 32767; 
    subtype int32_t is integer range -2147483648 to 2147483647; 
    constant fract : integer := 9; 

    signal uu_in, uu_out, y0, x0, z0 : int16_t; 
    signal k : integer range 0 to 7; 
begin 
    u_out <= std_logic_vector(to_signed(uu_out, u_out'lenght)); 

    seq_p : PROCESS(clk)
    BEGIN 
        if rising_edge(clk) then 
            if reset = 1 then 
                state <= idle; 
            else 
                state <= next_state; 
            end if; 
        end if; 
    END PROCESS seq_p; 

    comb_p : PROCESS(start, state, y0, k)
    BEGIN 
        done <= '0'; 
        case state is 
            when idle   => 
                uu_in <= to_integer(to_signed(u_in)); 
                if start = '1' then 
                    state <= idle; 
                end if; 
            when init   =>
                y0 <= 1 + uu_in/2; 
                x0 <= 1 - uu_in/2; 
                z0 <= 0; 
                k  <= 0; 
                state <= next_state; 
            when iter   =>
                if rising_edge(clk) then 
                    if k<7 then 
                        if y0 < 0 then 
                            y0 <= y0 + 2**(-k) * x0;
                            z0 <=  z0 - 2**(-k); 
                        else 
                            y0 <= y0 - 2**(-k) * x0;
                            z0 <=  z0 + 2**(-k); 
                        end if; 
                        k <= k + 1; 
                    end if; 
                end if;
                state <= next_state;  
            when final  =>
                done <= '1'; 
                if start = 1 then 
                    state <= idle; 
                end if;
        end case; 
    END PROCESS comb_p; 
end behavioural; 