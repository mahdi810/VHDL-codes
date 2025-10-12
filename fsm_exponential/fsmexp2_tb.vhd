library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_fsmexp is
end tb_fsmexp;

architecture testbench of tb_fsmexp is
    component fsmexp is
        port(
            clk   : in  std_logic;
            reset : in  std_logic;
            start : in  std_logic;
            u_in  : in  std_logic_vector(15 downto 0);
            u_out : out std_logic_vector(15 downto 0);
            done  : out std_logic
        );
    end component;

    signal clk      : std_logic := '0';
    signal reset    : std_logic := '1';
    signal start    : std_logic := '0';
    signal u_in     : std_logic_vector(15 downto 0) := (others => '0');
    signal u_out    : std_logic_vector(15 downto 0);
    signal done     : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    dut: fsmexp
        port map (
            clk   => clk,
            reset => reset,
            start => start,
            u_in  => u_in,
            u_out => u_out,
            done  => done
        );

    clk_process : process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stimulus_process : process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        -- Test case 1: u_in = 0 (exp(0) ≈ 1)
        u_in <= std_logic_vector(to_signed(0, 16));
        start <= '1';
        wait until done = '1';
        start <= '0';
        assert u_out = std_logic_vector(to_signed(256, 16)) 
            report "Test case 1 failed: expected 256" severity error;
        wait for 20 ns;

        -- Test case 2: u_in = 128 (0.5 in Q8.8)
        u_in <= std_logic_vector(to_signed(128, 16));
        start <= '1';
        wait until done = '1';
        start <= '0';
        -- Expected: (1 + 0.5/2) / (1 - 0.5/2) = 1.25 / 0.75 ≈ 1.6667 → 426 in Q8.8
        assert u_out = std_logic_vector(to_signed(426, 16)) 
            report "Test case 2 failed: expected 426" severity error;
        wait for 20 ns;

        -- Test case 3: u_in = -128 (-0.5 in Q8.8)
        u_in <= std_logic_vector(to_signed(-128, 16));
        start <= '1';
        wait until done = '1';
        start <= '0';
        -- Expected: (1 - 0.5/2) / (1 + 0.5/2) = 0.75 / 1.25 = 0.6 → 153 in Q8.8
        assert u_out = std_logic_vector(to_signed(153, 16)) 
            report "Test case 3 failed: expected 153" severity error;
        wait for 20 ns;

        -- Test case 4: u_in = 256 (1.0 in Q8.8)
        u_in <= std_logic_vector(to_signed(256, 16));
        start <= '1';
        wait until done = '1';
        start <= '0';
        -- Expected: (1 + 1/2) / (1 - 1/2) = 1.5 / 0.5 = 3 → 768 in Q8.8
        assert u_out = std_logic_vector(to_signed(768, 16)) 
            report "Test case 4 failed: expected 768" severity error;
        wait for 20 ns;

        -- Test case 5: u_in = -256 (-1.0 in Q8.8)
        u_in <= std_logic_vector(to_signed(-256, 16));
        start <= '1';
        wait until done = '1';
        start <= '0';
        -- Expected: (1 - 1/2) / (1 + 1/2) = 0.5 / 1.5 ≈ 0.3333 → 85 in Q8.8
        assert u_out = std_logic_vector(to_signed(85, 16)) 
            report "Test case 5 failed: expected 85" severity error;
        wait for 20 ns;

        report "All test cases completed." severity note;
        wait;
    end process;

end testbench;