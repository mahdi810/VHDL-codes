library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fib2 is
    port(
        clk    : in  std_logic;
        reset  : in  std_logic;
        start  : in  std_logic;
        n      : in  integer;
        y_out  : out unsigned(31 downto 0)
    );
end entity;

architecture bhv of fib2 is
    type type_state is (idle, calculating);
    signal state, next_state : type_state := idle;

    signal r1, r2       : unsigned(31 downto 0) := (others => '0');
    signal r1_next, r2_next : unsigned(31 downto 0);
    signal n_i, n_i_next : integer := 0;
begin

    -- Sequential process: registers and state updates
    seq_p : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                r1 <= (others => '0');
                r2 <= (others => '0');
                n_i <= 0;
                state <= idle;
            else
                r1 <= r1_next;
                r2 <= r2_next;
                n_i <= n_i_next;
                state <= next_state;
            end if;
        end if;
    end process seq_p;

    -- Combinational process: next state logic and Fibonacci computation
    comb_p : process(state, start, r1, r2, n_i, n_i_next)
    begin
        -- Default assignments
        r1_next    <= r1;
        r2_next    <= r2;
        n_i_next   <= n_i;
        next_state <= state;

        case state is
            when idle =>
                if start = '1' then
                    r1_next  <= (others => '0');  -- Fib(0)
                    r2_next  <= (others => '0');  -- will set Fib(1) below
                    n_i_next <= n;
                    next_state <= calculating;
                end if;

            when calculating =>
                -- Special case for first and second terms
                if n_i = 0 then
                    -- No terms to produce, finish
                    next_state <= idle;
                elsif n_i = 1 then
                    -- Output Fib(0)
                    r1_next <= (others => '0');
                    r2_next <= (others => '0');
                    n_i_next <= 0;
                    next_state <= idle;
                elsif n_i = 2 then
                    -- Output Fib(1)
                    r1_next <= (others => '0');
                    r2_next <= to_unsigned(1, 32);
                    n_i_next <= n_i - 1;
                else
                    -- Normal Fibonacci calculation
                    r1_next <= r2;
                    r2_next <= r1 + r2;
                    n_i_next <= n_i - 1;
                end if;

                if n_i <= 1 then
                    next_state <= idle;
                end if;

        end case;
    end process comb_p;

    y_out <= r1;

end architecture;
