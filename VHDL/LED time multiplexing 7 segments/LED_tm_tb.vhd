library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity LED_tm_tb is
end entity;

architecture bhv of LED_tm_tb is
    component LED_tm is
        port (
            in0, in1, in2, in3 : in std_logic_vector(7 downto 0);
            enable : in std_logic;
            reset : in std_logic;
            clk : in std_logic;
            sseg : out std_logic_vector(7 downto 0);
            an : out std_logic_vector(3 downto 0));
    end component LED_tm;
    constant clk_periode : time := 10 ns;
    signal in0, in1, in2, in3, sseg : std_logic_vector(7 downto 0) := (others => '0');
    signal enable, reset, clk : std_logic := '0';
    signal an : std_logic_vector(3 downto 0) := (others => '0');

begin

    --clock generation 
    clk_p : process
    begin
        clk <= '0';
        wait for clk_periode/2;
        clk <= '1';
        wait for clk_periode/2;
    end process clk_p;

    uut : LED_tm
    port map(
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3,
        clk => clk,
        reset => reset,
        sseg => sseg,
        an => an,
        enable => enable);

    stim_p : process
    begin
        in0 <= x"51";
        in1 <= x"42";
        in2 <= x"36";
        in3 <= x"65";
        enable <= '1';
        reset <= '0';
        wait for 5 sec;

        wait;
    end process stim_p;

end bhv;