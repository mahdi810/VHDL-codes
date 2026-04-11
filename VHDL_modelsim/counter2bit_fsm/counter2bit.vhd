-- Created by fizzim.pl version 5.20 on 2026:04:07 at 15:13:28 (www.fizzim.com)

library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counter2bit is
	port (
		count : out std_logic_vector(1 downto 0);
		clk : in std_logic;
		resetN : in std_logic;
		start : in std_logic
	);
end counter2bit;

architecture fizzim of counter2bit is

	-- state bits
	subtype state_type is std_logic_vector(2 downto 0);

	constant IDLE : state_type := "000";
	constant state0 : state_type := "001";
	constant state1 : state_type := "010";
	constant state2 : state_type := "011";
	constant state3 : state_type := "100";

	signal state, nextstate : state_type;
	signal count_internal : std_logic_vector(1 downto 0);

	-- comb always block
begin
	COMB : process (state, start) begin
		-- Warning I2: Neither implied_loopback nor default_state_is_x attribute is set on state machine - defaulting to implied_loopback to avoid latches being inferred 
		nextstate <= state; -- default to hold value because implied_loopback is set
		case state is
			when IDLE =>
				if (start = '1') then
					nextstate <= state0;
				end if;

			when state0 =>
				nextstate <= state1;

			when state1 =>
				nextstate <= state2;

			when state2 =>
				nextstate <= state3;

			when state3 =>
				-- Warning P3: State state3 has multiple exit transitions, and transition trans4 has no defined priority 
				-- Warning P3: State state3 has multiple exit transitions, and transition trans6 has no defined priority 
				if (start = '0') then
					nextstate <= IDLE;
				elsif (start = '1') then
					nextstate <= state0;
				end if;

			when others =>

		end case;
	end process;

	-- Assign reg'd outputs to state bits

	-- Port renames for vhdl
	count(1 downto 0) <= count_internal(1 downto 0);

	-- sequential always block
	FF : process (clk, resetN, nextstate) begin
		if (resetN = '0') then
			state <= IDLE;
		elsif (rising_edge(clk)) then
			state <= nextstate;
		end if;
	end process;

	-- datapath sequential always block
	DP : process (clk, resetN, nextstate) begin
		if (resetN = '0') then
			-- Warning R18: No reset value set for datapath output count[1:0].   Assigning a reset value of "00" based on value in reset state IDLE 
			count_internal(1 downto 0) <= "00";
		elsif (rising_edge(clk)) then
			count_internal(1 downto 0) <= "00"; -- default
			case nextstate is
				when IDLE =>
					count_internal(1 downto 0) <= "00";

				when state0 =>
					count_internal(1 downto 0) <= "00";

				when state1 =>
					count_internal(1 downto 0) <= "01";

				when state2 =>
					count_internal(1 downto 0) <= "10";

				when state3 =>
					count_internal(1 downto 0) <= "11";

					-- formality insists on this...
				when others =>

			end case;
		end if;
	end process;
end fizzim;