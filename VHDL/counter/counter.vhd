-- Created by fizzim.pl version 5.20 on 2026:04:06 at 17:22:07 (www.fizzim.com)

library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL; 

entity counter is
port (
  count : out STD_LOGIC;
  clock : in STD_LOGIC;
  start : in STD_LOGIC
);
end counter;

architecture fizzim of counter is

-- state bits
subtype state_type is STD_LOGIC_VECTOR(3 downto 0);

constant state0: state_type:="0000"; -- extra=000 count=0 
constant state1: state_type:="0001"; -- extra=000 count=1 
constant state2: state_type:="0011"; -- extra=001 count=1 
constant state3: state_type:="0101"; -- extra=010 count=1 
constant state4: state_type:="0111"; -- extra=011 count=1 
constant state5: state_type:="1001"; -- extra=100 count=1 

signal state,nextstate: state_type;
signal count_internal: STD_LOGIC;

-- comb always block
begin
  COMB: process(state,clock,start) begin
    -- Warning I2: Neither implied_loopback nor default_state_is_x attribute is set on state machine - defaulting to implied_loopback to avoid latches being inferred 
    nextstate <= state; -- default to hold value because implied_loopback is set
    case state is
      when state0 =>
        if (start <= '1' ) then
          nextstate <= state1;
        end if;

      when state1 =>
        nextstate <= state2;

      when state2 =>
        nextstate <= state3;

      when state3 =>
        nextstate <= state4;

      when state4 =>
        nextstate <= state5;

      when state5 =>
        nextstate <= state0;

      when others =>

    end case;
  end process;

  -- Assign reg'd outputs to state bits
  count_internal <= state(0);

  -- Port renames for vhdl
  count <= count_internal;

  -- sequential always block


end fizzim; 
