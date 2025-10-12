-- Engineer : Mohammad Mahdi Mohammadi 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity freq_divider is
    generic(
        MAX_COUNT : integer := 8333333  -- For 6 Hz from 100 MHz
    );
    port(
        clk       : in  std_logic;      -- 100 MHz clock
        reset     : in  std_logic;      -- active-high reset
        pulse_rot : out std_logic       -- reduced frequency output
    );
end entity freq_divider;

architecture rtl of freq_divider is
    signal cnt     : integer range 0 to MAX_COUNT := 0;
    signal out_reg : std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            cnt     <= 0;
            out_reg <= '0';
        elsif rising_edge(clk) then
            if cnt = MAX_COUNT then
                cnt     <= 0;
                out_reg <= not out_reg;  -- toggle output
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;

    pulse_rot <= out_reg;
end architecture rtl;