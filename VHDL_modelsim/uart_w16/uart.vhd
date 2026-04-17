library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity uart is 
    port(
        clk, start, reset : in std_logic; 
        txdata : in std_logic_vector(7 downto 0); 
        TxD : out std_logic; 
        done : out std_logic
    ); 
end uart; 

architecture bhv of uart is 
    type state_type is (idle, state_start, state_data, state_parity); 
    signal state, next_state : state_type; 
    signal count, count_reg : integer := 0; 
begin 

    --sequential circuit 
    seq_p : process(clk, reset)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= idle;
                count <= 0;  
            else 
                state <= next_state; 
                count <= count_reg; 
            end if; 
        end if; 
    end process seq_p; 

    --combinational circuit 
    comb_p : process(state, start, count)
    begin
        --defautl cases 
        next_state <= state; 
        count_reg <= count; 
        TxD <= '1'; 
        done <= '0'; 

        case state is  
            when idle          =>  
                done <= '1'; 
                TxD <= '1'; 
                if start = '1' then 
                    next_state <= state_start; 
                end if; 
            when state_start =>
                Txd <= '0'; 
                count_reg <= 0; 
                next_state <= state_data;  
            when state_data    =>  
                TxD <= txdata(count); 
                count_reg <= count + 1; 
                if count = 7 then 
                    next_state <= state_parity; 
                end if; 
            when state_parity  =>  
                TxD <= txdata(0) XOR txdata(1) XOR txdata(2) XOR txdata(3) XOR txdata(4) XOR txdata(5) XOR txdata(6) XOR txdata(7) XOR '1'; 
                next_state <= idle; 
        end case; 
    end process;


end bhv; 