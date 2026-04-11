-- Created by fizzim.pl version 5.20 on 2026:04:07 at 22:01:08 (www.fizzim.com)

library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity led_fsm2 is
    port (
        L : out std_logic_vector(2 downto 0);
        b0 : in std_logic;
        clk : in std_logic;
        reset : in std_logic
    );
end led_fsm2;

architecture fizzim of led_fsm2 is

    -- state bits
    subtype state_type is std_logic_vector(2 downto 0);

    constant state0 : state_type := "000";
    constant state1 : state_type := "001";
    constant state2 : state_type := "010";
    constant state3 : state_type := "011";
    constant state4 : state_type := "100";
    constant state5 : state_type := "101";
    constant state6 : state_type := "110";
    constant state7 : state_type := "111";

    signal state, nextstate : state_type;
    signal L_internal : std_logic_vector(2 downto 0);

    -- comb always block
begin
    COMB : process (state, b0) begin
        -- Warning I2: Neither implied_loopback nor default_state_is_x attribute is set on state machine - defaulting to implied_loopback to avoid latches being inferred 
        nextstate <= state; -- default to hold value because implied_loopback is set
        case state is
            when state0 =>
                if (b0 = '0') then
                    nextstate <= state1;
                end if;

            when state1 =>
                -- Warning P3: State state1 has multiple exit transitions, and transition trans1 has no defined priority 
                -- Warning P3: State state1 has multiple exit transitions, and transition trans8 has no defined priority 
                if (b0 = '0') then
                    nextstate <= state2;
                elsif (b0 = '1') then
                    nextstate <= state0;
                end if;

            when state2 =>
                -- Warning P3: State state2 has multiple exit transitions, and transition trans2 has no defined priority 
                -- Warning P3: State state2 has multiple exit transitions, and transition trans9 has no defined priority 
                if (b0 = '0') then
                    nextstate <= state3;
                elsif (b0 = '1') then
                    nextstate <= state0;
                end if;

            when state3 =>
                -- Warning P3: State state3 has multiple exit transitions, and transition trans10 has no defined priority 
                -- Warning P3: State state3 has multiple exit transitions, and transition trans3 has no defined priority 
                if (b0 = '1') then
                    nextstate <= state0;
                elsif (b0 = '0') then
                    nextstate <= state4;
                end if;

            when state4 =>
                -- Warning P3: State state4 has multiple exit transitions, and transition trans11 has no defined priority 
                -- Warning P3: State state4 has multiple exit transitions, and transition trans4 has no defined priority 
                if (b0 = '1') then
                    nextstate <= state0;
                elsif (b0 = '0') then
                    nextstate <= state5;
                end if;

            when state5 =>
                -- Warning P3: State state5 has multiple exit transitions, and transition trans12 has no defined priority 
                -- Warning P3: State state5 has multiple exit transitions, and transition trans5 has no defined priority 
                if (b0 = '1') then
                    nextstate <= state0;
                elsif (b0 = '0') then
                    nextstate <= state6;
                end if;

            when state6 =>
                -- Warning P3: State state6 has multiple exit transitions, and transition trans13 has no defined priority 
                -- Warning P3: State state6 has multiple exit transitions, and transition trans6 has no defined priority 
                if (b0 = '1') then
                    nextstate <= state0;
                elsif (b0 = '0') then
                    nextstate <= state7;
                end if;

            when state7 =>
                if (b0 = '1') then
                    nextstate <= state0;
                end if;

            when others =>

        end case;
    end process;

    -- Assign reg'd outputs to state bits

    -- Port renames for vhdl
    L(2 downto 0) <= L_internal(2 downto 0);

    -- sequential always block
    FF : process (clk, reset, nextstate) begin
        if (reset = '1') then
            state <= state0;
        elsif (rising_edge(clk)) then
            state <= nextstate;
        end if;
    end process;

    -- datapath sequential always block
    DP : process (clk, reset, nextstate) begin
        if (reset = '1') then
            -- Warning R18: No reset value set for datapath output L[2:0].   Assigning a reset value of "000" based on value in reset state state0 
            L_internal(2 downto 0) <= "000";
        elsif (rising_edge(clk)) then
            L_internal(2 downto 0) <= "000"; -- default
            case nextstate is
                when state1 =>
                    L_internal(2 downto 0) <= "001";

                when state2 =>
                    L_internal(2 downto 0) <= "010";

                when state3 =>
                    L_internal(2 downto 0) <= "011";

                when state4 =>
                    L_internal(2 downto 0) <= "100";

                when state5 =>
                    L_internal(2 downto 0) <= "101";

                when state6 =>
                    L_internal(2 downto 0) <= "110";

                when state7 =>
                    L_internal(2 downto 0) <= "111";

                    -- formality insists on this...
                when others =>

            end case;
        end if;
    end process;
end fizzim;