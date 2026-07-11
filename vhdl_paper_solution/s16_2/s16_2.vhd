LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY s16_2 IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		L : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		y : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE behavioral OF s16_2 IS
	TYPE state_type IS (st0, st1, st2, st3, st4, st5, st6, st7, st8);
	SIGNAL state : state_type;

BEGIN

	-- fsm_p 
	fsm_p : PROCESS (clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF reset = '1' THEN
				state <= st0;
				y <= (OTHERS => '0');
			ELSE
				-- default cases 
				y <= (OTHERS => '0');

				CASE state IS
					WHEN st0 =>
						IF L(0) = '1' THEN
							y <= "001110";
						ELSIF L(0) = '0' THEN
							state <= st1;
						END IF;
					WHEN st1 =>
						IF L(1) = '1' THEN
							y <= "100101";
						ELSIF L(1) = '0' THEN
							state <= st2;
						END IF;
					WHEN st2 =>
						IF L(2) = '1' THEN
							y <= "100110";
						ELSIF L(2) = '0' THEN
							state <= st3;
						END IF;
					WHEN st3 =>
						IF L(3) = '1' THEN
							y <= "010011";
						ELSIF L(3) = '0' THEN
							state <= st4;
						END IF;
					WHEN st4 =>
						IF L(4) = '1' THEN
							y <= "010101";
						ELSIF L(4) = '0' THEN
							state <= st6;
						END IF;
					WHEN st5 =>
						IF L(5) = '1' THEN
							y <= "010110";
						ELSIF L(5) = '0' THEN
							state <= st6;
						END IF;
					WHEN st6 =>
						IF L(6) = '1' THEN
							y <= "001011";
						ELSIF L(6) = '0' THEN
							state <= st7;
						END IF;
					WHEN st7 =>
						IF L(7) = '1' THEN
							y <= "001101";
						ELSIF L(7) = '0' THEN
							state <= st8;
						END IF;
					WHEN st8 =>
						IF L(8) = '1' THEN
							y <= "001110";
						ELSIF L(8) = '0' THEN
							state <= st0;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS fsm_p;
END behavioral;