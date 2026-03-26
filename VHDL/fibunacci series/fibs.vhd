library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fibs is
    port(
        clk : in std_logic; 
        reset : in std_logic; 
        start : in std_logic; 
        done : out std_logic; 
        n : in unsigned(7 downto 0); 
        y_out : out unsigned(7 downto 0)
    ); 
end fibs; 

architecture behavioral of fibs is 
subtype int16_t is integer range -32768 to 32767;
signal f0, f1 : int16_t := 0;
signal count : int16_t := 0;
signal result : int16_t := 0;
type state_type is (idle, sstartx, run); 
signal state : state_type := idle; 
begin 

    --the main process to calculate the fibunacci series;
    fib_p : process(clk)
    variable next_f : int16_t;
    begin 
        if rising_edge(clk) then 
            if reset = '1' then
                state <=  idle; 
                f0 <=  0; 
                f1 <=  0; 
                count <= 0;
                result <= 0; 
            else 
                case state is 
                    when idle => 
                        if start = '1' then 
                            state <= sstartx; 
                        end if; 
                    when sstartx =>  
                        -- Handle base cases directly before iterative run.
                        if to_integer(n) = 0 then
                            result <= 0;
                            state <= idle;
                        elsif to_integer(n) = 1 then
                            result <= 1;
                            state <= idle;
                        else
                            f0 <= 0;
                            f1 <= 1;
                            result <= 1;
                            count <= to_integer(n) - 1;
                            state <= run;
                        end if;
                    when run =>  
                        next_f := f0 + f1;
                        result <= next_f;
                        f0 <= f1;
                        f1 <= next_f;
                        if count = 1 then
                            state <= idle;
                        else
                            count <= count - 1;
                        end if; 
                end case; 
            end if; 
        end if; 
    end process fib_p; 

    done <= '1' when state = idle else '0';
    y_out <= to_unsigned(result, 8);

end behavioral; 