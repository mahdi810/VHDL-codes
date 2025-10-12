LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 

ENTITY tlcsimple_tb is 
END entity; 

ARCHITECTURE behavioural OF tlcsimple_tb IS 
COMPONENT tlcsimple is  
    PORT( 
            treset : in STD_LOGIC; 
            tclk : in STD_LOGIC;
            normal_operation : in STD_LOGIC; 
            night_operation : in STD_LOGIC; 
            red : out STD_LOGIC; 
            green : out STD_LOGIC; 
            amber : out STD_LOGIC
            
    );

END COMPONENT tlcsimple ;

SIGNAL treset : STD_LOGIC := '0'; 
SIGNAL tclk : STD_LOGIC := '0'; 
SIGNAL normal_operation : STD_LOGIC := '0'; 
SIGNAL night_operation : STD_LOGIC := '0'; 
SIGNAL red : STD_LOGIC := '0'; 
SIGNAL green : STD_LOGIC := '0'; 
SIGNAL amber : STD_LOGIC := '0';     

BEGIN 

    uut : tlcsimple
        PORT MAP(
                    treset               
                    tclk 
                    normal_operation
                    night_operation 
                    red 
                    green 
                    amber 







        )




END behavioural; 