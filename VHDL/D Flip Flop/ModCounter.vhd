library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity ModCounter is 
    generic ( N : integer :=  4; --number of bits
              M : integer := 10); --mode counter) 
    port ( clk, reset : in std_logic; 
           max_tick : out std_logic; 
           q : out std_logic_vector(N-1 downto 0));
end entity; 

architecture bhv of ModCounter is 
    signal r_reg : unsigned(N-1 downto 0) := (others => '0'); 
    signal r_next : unsigned(N-1 downto 0) := (others => '0'); 

begin 
    -- counter_p : process(clk, reset)
    -- begin 
    --     if rising_edge(clk) then 
    --         if reset = '1' then 
    --             counter <= (others => '0'); 
    --             max_tick <= '0'; 
    --         else 
    --             if counter < to_unsigned(M, N-1) then 
    --                 counter <= counter + 1; 
    --                 if counter = to_unsigned(M, N-1) then 
    --                     max_tick <= '1'; 
    --                 end if; 
    --             end if; 
    --         end if; 
    --     end if; 
    -- end process counter_p; 

    --registers 
    seq_p : process(clk, reset)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                r_reg <= (others => '0'); 
            else 
                r_reg <= r_next; 
            end if; 
        end if; 
    end process seq_p; 

    --next state logic 
    r_next <= (others => '0') when r_reg = to_unsigned(M-1, N) else 
        r_reg + 1; 


    --output logic 
    q <= std_logic_vector(r_reg); 
    max_tick <= '1' when r_reg = to_unsigned(M-1, N) else 
                '0'; 
   

end bhv; 