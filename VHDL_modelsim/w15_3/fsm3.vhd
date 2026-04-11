library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm3 is
    port (
        clk : in std_logic;
        reset, enable : in std_logic;
        ctr_err : in std_logic_vector(7 downto 0);
        heat, cool : out std_logic
    );
end fsm3;

architecture bhv of fsm3 is

    subtype int8_t is integer range -128 to 127;
    signal ctr_err_i : int8_t := 0;
    type state_type is (state_off, state_heat, state_cool);
    signal state, next_state : state_type;

begin

    ctr_err_i <= to_integer(signed(ctr_err));

    --sequential circuit 
    seq_p : process (clk, reset, enable)
    begin
        if (clk'event and clk = '1') then
            if reset = '1' then
                state <= state_off;
            else
                if enable = '1' then
                    state <= next_state;
                end if;
            end if;
        end if;
    end process seq_p;

    --combinational process 
    comb_p : process (state, ctr_err_i)
    begin
        --default values 
        next_state <= state;
        heat <= '0';
        cool <= '0';

        case state is
            when state_off =>
                heat <= '0';
                cool <= '0';
                if ctr_err_i > 55 then
                    next_state <= state_heat;
                elsif ( ctr_err_i < -30) then
                    next_state <= state_cool;
                end if;
            when state_heat =>
                heat <= '1';
                cool <= '0';
                if (ctr_err_i < 25) then
                    next_state <= state_off;
                end if;
            when state_cool =>
                heat <= '0';
                cool <= '1';
                if (ctr_err_i > -14) then
                    next_state <= state_off;
                end if;
        end case;
    end process comb_p;

end bhv;