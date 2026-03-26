--Engineer : Mohammad Mahdi Mohammadi 
--this circuit uses time multiplexing to reduce the number of bit required for displaying the four 7 segement displays. 
--it uses high frequency to turn each of the 7 segment display and make the illusion that all of them are on at the same time. 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED_tm is
    port (
        in0, in1, in2, in3 : in std_logic_vector(7 downto 0);
        enable : in std_logic;
        reset : in std_logic;
        clk : in std_logic;
        sseg : out std_logic_vector(7 downto 0);
        an : out std_logic_vector(3 downto 0));
end entity;

architecture bhv of LED_tm is
    type state_type is (idle, st0, st1, st2, st3);
    signal state, next_state : state_type;
    signal clk_out : std_logic := '0';
    constant max_count : integer := 49999; --for an output frequency of 1000Hz 
    subtype counter_type is integer range 0 to max_count;

begin

    --clock division
    clk_div : process (clk)
        variable cnt : counter_type := 0;
    begin
        if RISING_EDGE(clk) then
            if reset = '1' then
                cnt := 0;
                clk_out <= '0';
            else
                if cnt = max_count then
                    cnt := 0;
                    clk_out <= not clk_out;
                else
                    cnt := cnt + 1;
                end if;
            end if;
        end if;
    end process clk_div;

    --here the clock should be at least 1000Hz and the high frequency clock of the fpga should not be USEd.
    --the clock should be divided and THEN USEd. 
    --sequential PROCESS 
    seq_p : process (clk_out, reset)
    begin
        if rising_edge(clk_out) then
            if reset = '1' then
                state <= idle;
            else
                state <= next_state;
            end if;
        end if;
    end process seq_p;

    --combinational PROCESS
    comb_p : process (enable, state)
    begin
        --defaults 
        next_state <= state;
        case state is
            when idle =>
                sseg <= (others => '0');
                an <= (others => '0');
                if enable = '1' then
                    next_state <= st0;
                end if;
            when st0 =>
                sseg <= in0;
                an <= "1110";
                next_state <= st1;
            when st1 =>
                sseg <= in1;
                an <= "1101";
                next_state <= st2;
            when st2 =>
                sseg <= in2;
                an <= "1011";
                next_state <= st3;
            when st3 =>
                sseg <= in3;
                an <= "0111";
                if enable = '1' then
                    next_state <= st0;
                else
                    next_state <= idle;
                end if;
        end case;
    end process comb_p;
end bhv;