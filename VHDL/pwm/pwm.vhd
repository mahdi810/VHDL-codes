library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
    generic(NBIT : integer := 12); 
    port (
        clk : in std_logic;
        pval : in std_logic_vector(NBIT -1  downto 0); 
        pwmout : out std_logic
    );
end pwm;

architecture bhv of pwm is 
subtype int12_t is integer range 0 to 2**NBIT; 
signal count : int12_t := 0; 

begin 

    --free running counter process 
    counter : process(clk)
    begin 
        if rising_edge(clk) then 
            if count = 2**NBIT then 
                count <= 0; 
            else
            count <= count + 1; 
            end if; 
        end if; 
    end process counter; 


end bhv; 