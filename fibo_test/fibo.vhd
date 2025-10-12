begin 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fibo is
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
        n      : in  integer;
        u_out  : out unsigned(31 downto 0);
        done   : out std_logic;
        start  : in  std_logic
    );
end fibo;

architecture rtl of fibo is
    type my_state is (idle, init, fibo1, final);
    signal state, next_state         : my_state;
    signal u_out2, u_out2_next      : unsigned(31 downto 0) := (others => '0');
    signal u_out1, u_out1_next      : unsigned(31 downto 0) := (others => '0');
    signal n_i, n_i_next            : integer := 0;
    signal done_reg, done_next      : std_logic := '0';
begin

    -- Sequential process
    seq_p : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state    <= idle;
                u_out1   <= (others => '0');
                u_out2   <= (others => '0');
                n_i      <= 0;
                done_reg <= '0';
            else
                state    <= next_state;
                u_out1   <= u_out1_next;
                u_out2   <= u_out2_next;
                n_i      <= n_i_next;
                done_reg <= done_next;
            end if;
        end if;
    end process seq_p;

    -- Combinational process
    comb_p : process(state, n, u_out1, u_out2, n_i, start)
    begin
        -- Default assignments
        u_out1_next <= u_out1;
        u_out2_next <= u_out2;
        n_i_next    <= n_i;
        next_state  <= state;
        done_next   <= '0';

        case state is
            when idle =>
                done_next <= '1';
                if start = '1' then
                    next_state <= init;
                end if;
            when init =>
                done_next    <= '0';
                n_i_next     <= 0;
                u_out1_next  <= (others => '0');
                u_out2_next  <= x"00000001";
                next_state   <= fibo1;
            when fibo1 =>
                done_next    <= '0';
                u_out1_next  <= u_out2;
                u_out2_next  <= u_out1 + u_out2;
                n_i_next     <= n_i + 1;
                if n_i = n then
                    next_state <= final;
                end if;
            when final =>
                done_next   <= '1';
                next_state  <= idle;
        end case;
    end process comb_p;

    u_out <= u_out2;
    done  <= done_reg;
end rtl;