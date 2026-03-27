library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter is
    port(
        clk : in std_logic; 
        reset : in std_logic; 
        count : out std_logic_vector(3 downto 0)
    ); 
end bcd_counter;

architecture behavioral of bcd_counter is
    type state_type is (zero, one, two, three, four, five, six, seven, eight, nine);
    signal state, next_state : state_type;
begin

    --for calculating the current state 
    seq_p : process(clk, reset)
    begin 
        if reset = '1' then 
            state <= zero; 
        else
            if rising_edge(clk) then 
                state <= next_state; 
            end if; 
        end if; 
    end process seq_p; 

    --for calculating the next state 
    comb_p : process(state, next_state)
    begin 
        next_state <= state; 
        case state is 
            when zero  => 
                count <= x"0"; 
                next_state <= one; 
            when one   => 
                count <= x"1"; 
                next_state <= two; 
            when two   => 
                count <= x"2"; 
                next_state <= three; 
            when three => 
                count <= x"4"; 
                next_state <= four; 
            when four  => 
                count <= x"5"; 
                next_state <= five;
            when five  => 
                count <= x"6"; 
                next_state <= six;
            when six   => 
                count <= x"7"; 
                next_state <= seven;
            when seven => 
                count <= x"8"; 
                next_state <= eight;
            when eight => 
                count <= x"9"; 
                next_state <= nine;
            when nine  => 
                count <= x"0"; 
                next_state <= zero;
        end case; 
    end process comb_p; 


end behavioral;