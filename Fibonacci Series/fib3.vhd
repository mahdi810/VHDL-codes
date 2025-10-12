library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fib3 is 
    port (clk, reset, start : in std_logic; 
          y_out : out unsigned(31 downto 0);
          n : in integer;  
          done : out std_logic ); 
end entity; 

architecture bhv of fib3 is 
type state_type is (idle, st1, st2); 
signal state : state_type ; 
signal r1, r2 : unsigned(31 downto 0):= (others =>'0');
signal n_i : integer := 0; 
begin 

    --fsm process
    fsm : process(clk, reset, state)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                r1 <= (others => '0'); 
                r2 <= (others => '0'); 
                n_i <= n; 
            else 
                case state is 
                    when idle =>
                        r1 <= (others =>'0');
                        r2 <= (others =>'0');
                        n_i <= n-2; 
                        if start = '1' then 
                            state <= st1; 
                        else 
                            state <= idle; 
                        end if; 
                    when st1 => 
                        r1 <= r2; 
                        r2 <= r1 + r2; 
                        n_i <= n_i - 1; 
                        state <= st2; 
                    when st2 =>
                        r1 <= r2; 
                        r2 <= r1 + r2; 
                        n_i <= n_i - 1; 
                        if n_i = 0 then
                            state <= idle; 
                        else 
                            state <= st1; 
                        end if; 
                end case; 
            end if; 
        end if; 
    end process fsm; 




end bhv; 