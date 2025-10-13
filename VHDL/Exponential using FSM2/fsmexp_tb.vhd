----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mohammad Mahdi Mohammadi
-- 
-- Create Date: 10/13/2025 12:00:15 AM
-- Design Name: 
-- Module Name: fsmexp_tb - Behavioral
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


library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity fsmexp_tb is 
end entity; 

architecture bhv of fsmexp_tb is 
    component fsmexp is 
        generic (it_no : integer := 7);
        port (clk   : in std_logic;
              start : in std_logic;
              done  : out std_logic;
              reset : in std_logic;
              u_in  : in std_logic_vector(15 downto 0);
              u_out : out std_logic_vector(15 downto 0) );
    end component fsmexp;
    signal clk, start, done, reset : std_logic := '0'; 
    signal k : integer := 0; 
    signal u_in, u_out : std_logic_vector(15 downto 0) := (others => '0'); 
    constant clk_periode : time := 10 ns; 
    constant max_count : integer := 0; 
    constant it_no : integer := 10; 

begin 

    --clock generation 
    clk_p : process
    begin 
        clk <= '0'; 
        wait for clk_periode/2; 
        clk <= '1'; 
        wait for clk_periode/2; 
    end process clk_p; 

    uut : entity work.fsmexp
     generic map(
        it_no => it_no
    )
     port map(
        clk => clk,
        start => start,
        done => done,
        reset => reset,
        u_in => u_in,
        u_out => u_out
    );

    stim_p : process 
    begin 
        start <= '1'; 
        reset <= '0'; 
        u_in <= x"1000"; 
        wait for clk_periode * 40; 
        



        wait; 
    end process stim_p; 


end bhv; 