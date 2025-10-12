-- Engineer : Mohammad Mahdi Mohammadi 
-- Hochschule Bremerhaven 2025 

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.nemeric_std.all; 
use ieee.std_logic_unsigned.all; 

entity mvlight is 
	port( clk : in std_logic; 
		  start : in std_logic; 
		  reset : in std_logic; 
		  btnl : in std_logic; 
		  btnr : in std_logic; 
		  btnc : in std_logic; 
		  btnd : in std_logic; 
		  zswitch : in std_logic_vecotr (7 downto 0); 
		  zled : out std_logic_vector (7 downto 0));
	end entity mvlight; 
	
architecture behavioural of mvlight is 
	signal rot_right : std_logic := '0';
	signal rot_left : std_logic := '0'; 
	signal led_reg : std_logic_vecotr (7 downto 0) := x"03";
	constant max_count : integer := 3; 
	subtype counter_type is integer range 0 to max_count; 
	signal clk_out : std_logic; 
begin 

	-- generating a reduced pulse
	pulse_p : process(clk)
	variable cnt : counter_type := max_count; 
		begin 
			if rising_edge(clk) then 
				clk_out <= '0'; 
				if cnt = 0 then 
					clk_out <= '1'; 
				else 
					cnt := cnt - 1; 
				end if; 
			end if; 
		end process pulse_p; 





end behavioural; 
