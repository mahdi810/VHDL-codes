---------------------------------------------------------------
--Mohammad Mahdi Mohammadi, Hochschule Bremerhaven 
--06.03.2025
--signal generator using finite state machines in vhdl simulated in vivado design suit 2024
---------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity sg3211brk is
  port (
    --defining the input and output ports 
    reset : in std_logic;
    start : in std_logic;
    clk   : in std_logic;
    y_out : out std_logic
  );
end entity sg3211brk;

architecture behavioural of sg3211brk is
  type State_type is (st_off, st_a, st_b, st_c, st_d, st_e, st_f, st_g, st_brk);
  signal state, next_state : State_type;

  --to make a timer for the timed finite state machines 
  constant max_count : integer := 7; 
  subtype counter_type is integer range 0 to max_count; 
  signal timer : counter_type; 

begin
  seq_p : process (clk)
  variable cnt: counter_type := 0; 
  begin
    if rising_edge(clk) then
      if reset = '1' then
        state <= st_off;
        cnt := 0; 
      else
        if cnt = timer then 
          state <= next_state;
          cnt := 0; 
        else
          cnt := cnt + 1; 
        end if; 
      end if;
    end if;
  end process seq_p;

  comb_p : process (clk, start)
  begin
    --initailization of the states and the outputs. 
    y_out      <= '0';
    next_state <= state;
    case state is
      when st_off=>
        if start = '1' then 
          next_state <= st_a; 
        end if; 
      when st_a =>
        y_out <= '1'; 
        next_state <= st_b; 
        timer <= 2; 
      when st_b =>
        next_state <= st_c; 
      when st_c =>
        y_out <= '1'; 
        next_state <= st_d;
        timer <= 1;  
      when st_d =>
        next_state <= st_e; 
      when st_e =>
        y_out <= '1'; 
        next_state <= st_f; 
        timer <= 0; 
      when st_f =>
        next_state <= st_g; 
      when st_g =>
        y_out <= '1'; 
        next_state <= st_brk; 
        timer <= 0; 
      when st_brk=>
        if start = '1' then
          next_state <= st_a; 
          timer <= 3; 
        else 
          next_state <= st_off; 
        end if; 
      end case; 

    end process comb_p;
  end behavioural;