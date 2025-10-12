-- Engineer : Mohammad Mahdi Mohammadi
-- This program computes  
-- using a repetitive iteration method (approximation).

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsmexp is
    port(
        clk   : in  std_logic;
        reset : in  std_logic;
        start : in  std_logic;
        u_in  : in  std_logic_vector(15 downto 0);
        u_out : out std_logic_vector(15 downto 0);
        done  : out std_logic
    );
end fsmexp;

architecture behavioural of fsmexp is
    -- FSM states
    type my_state is (idle, init, iter, final);
    signal state, next_state : my_state;

    -- Integer subtypes for fixed precision
    subtype int16_t is integer range -32768 to 32767;
    subtype int32_t is integer range -2147483648 to 2147483647;

    -- Internal registers
    signal uu_in  : int16_t;
    signal uu_out : int16_t;
    signal y0, x0, z0 : int32_t;
    signal k : integer range 0 to 7 := 0;

begin
    -- Output assignment
    u_out <= std_logic_vector(to_signed(uu_out, u_out'length));

    -- Sequential process: state register
    seq_p : process(clk, reset)
    begin
        if reset = '1' then
            state <= idle;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process seq_p;

    -- Combinational process: FSM logic
    comb_p : process(state, start, uu_in, y0, x0, z0, k)
    begin
        -- Default values
        next_state <= state;
        done <= '0';

        case state is
            -- Waiting for start
            when idle =>
                if start = '1' then
                    next_state <= init;
                end if;

            -- Initialize algorithm
            when init =>
                uu_in <= to_integer(signed(u_in));
                y0    <= 1 + uu_in/2;
                x0    <= 1 - uu_in/2;
                z0    <= 0;
                k     <= 0;
                next_state <= iter;

            -- Perform iterations
            when iter =>
                if k < 7 then
                    if y0 < 0 then
                        y0 <= y0 + (x0 srl k);  -- shift-right 
                        z0 <= z0 - (1 sll k);   -- shift-left 
                    else
                        y0 <= y0 - (x0 srl k);
                        z0 <= z0 + (1 sll k);
                    end if;
                    k <= k + 1;
                    next_state <= iter;
                else
                    next_state <= final;
                end if;

            -- Final result
            when final =>
                uu_out <= int16_t(z0); -- approximate result
                done <= '1';
                if start = '0' then
                    next_state <= idle;
                end if;

        end case;
    end process comb_p;

end behavioural;
