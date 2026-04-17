<<<<<<< HEAD
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tb is
end uart_tb;

architecture bhv of uart_tb is
    component uart is
        port (
            clk, start, reset : in std_logic;
            txdata : in std_logic_vector(7 downto 0);
            TxD : out std_logic;
            done : out std_logic
        );
    end component uart;
    signal clk, reset, start, TxD, done : std_logic := '0';
    constant clk_period : time := 10 ns;
    signal txdata : std_logic_vector(7 downto 0) := (others => '0');

begin

    --clock generation 
    clk_p : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process clk_p;

    --unit under test 
    uart_inst : entity work.uart
        port map(
            clk => clk,
            start => start,
            reset => reset,
            txdata => txdata,
            TxD => TxD,
            done => done
        );

        --stimulus process 
        stim_p : process 
        begin 
            start <= '0'; 
            reset <= '1'; 
            txdata <= x"12"; 
            wait for clk_period * 3; 
            reset <= '0'; 
            wait for clk_period; 
            start <= '1'; 
            wait for clk_period; 
            start <= '0'; 
            wait for clk_period * 20; 
            
            wait; 
        end process stim_p;     

end bhv;
=======
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2026 10:02:28 PM
-- Design Name: 
-- Module Name: uart_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tb is
--  Port ( );
end uart_tb;

architecture Behavioral of uart_tb is

begin


end Behavioral;
>>>>>>> 19d413da98686b8f950cf200823f1feb30e15c03
