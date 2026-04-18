LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY w23_3_tb IS
END w23_3_tb;

ARCHITECTURE structural OF w23_3_tb IS

    SIGNAL clk, u : STD_LOGIC := '0';
    SIGNAL x, y : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    --clock generation 
    clk <= NOT clk AFTER clk_period/2;

    w23_3_inst : ENTITY work.w23_3
        PORT MAP(
            clk => clk,
            u => u,
            x => x,
            y => y
        );

    --stimulus process 
    stim_p : process 
    begin
        for k in 0 to 15 loop 
            u <= '0'; 
            x <= std_logic_vector(to_unsigned(k, x'length)); 
            wait for clk_period * 10; 
        end loop; 

        for k in 0 to 15 loop 
            u <= '1'; 
            x <= std_logic_vector(to_unsigned(k, x'length)); 
            wait for clk_period * 10; 
        end loop; 

        wait; 
    end process;
END structural; -- structural