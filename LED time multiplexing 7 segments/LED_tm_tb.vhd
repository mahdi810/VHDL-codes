LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.all; 

ENTITY LED_tm_tb IS 
END ENTITY; 

ARCHITECTURE bhv OF LED_tm_tb IS 
    COMPONENT LED_tm IS 
        PORT(in0, in1, in2,in3 : in std_logic_vector(7 downto 0); 
            enable : in std_logic; 
            reset : in std_logic;
            clk : in std_logic;  
            sseg : out std_logic_vector( 7 downto 0); 
            an : out std_logic_vector(3 downto 0) ); 
    END COMPONENT LED_tm; 
    CONSTANT clk_periode : TIME :=  10  ns; 
    SIGNAL in0, in1, in2, in3, sseg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); 
    SIGNAL enable, reset, clk : STD_LOGIC := '0'; 
    SIGNAL an : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

BEGIN 

    --clock generation 
    clk_p : PROCESS
    BEGIN 
        clk <= '0'; 
        WAIT FOR clk_periode/2; 
        clk <= '1'; 
        WAIT FOR clk_periode/2; 
    END PROCESS clk_p; 

    uut : LED_tm
        PORT MAP(in0 => in0, 
                 in1 => in1, 
                 in2 => in2, 
                 in3 => in3, 
                 clk => clk, 
                 reset => reset, 
                 sseg => sseg, 
                 an => an, 
                 enable => enable); 

    stim_p : PROCESS
    BEGIN 
        in0 <= x"51";
        in1 <= x"42";
        in2 <= x"36";
        in3 <= x"65";
        enable <= '1'; 
        reset <= '0'; 
        WAIT FOR 5 sec;  


        WAIT; 
    END PROCESS stim_p; 



END bhv; 