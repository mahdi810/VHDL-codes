LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY w23_2 IS
    PORT (
        clk, reset : IN STD_LOGIC;
        u : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_out : OUT STD_LOGIC
    );
END w23_2;

ARCHITECTURE behavioral OF w23_2 IS
    TYPE state_type IS (idle, st0, st1, st2, st3, st4, st5);
    SIGNAL state, next_state : state_type;
BEGIN

    --sequential process 
    seq_p : PROCESS (clk, reset)
    BEGIN
        IF rising_edge(clk) THEN
            IF reset = '1' THEN
                state <= idle;
            ELSE
                state <= next_state;
            END IF;
        END IF;
    END PROCESS seq_p;

    --combinational process 
    comb_p : PROCESS (state, u)
    BEGIN
        --default cases 
        next_state <= state;
        s_out <= '1';
        CASE state IS
            WHEN idle =>
                s_out <= '0';
                if (u = "01" or u = "10" or u = "11") then 
                    next_state <= st0; 
                end if; 
            WHEN st0 =>
                if (u = "01" or u = "10") then 
                    next_state <= st1; 
                elsif u = "01" then 
                    next_state <= st3; 
                end if; 
            WHEN st1 =>
                if (u = "11") then 
                    next_state <= st2; 
                elsif (u = "10") then 
                    next_state <= st4; 
                end if; 
            WHEN st2 =>
                if (u = "11") then 
                    next_state <= idle; 
                end if; 
            WHEN st3 =>
                s_out <= '0'; 
                next_state <= st4; 
            WHEN st4 =>
                s_out <= '0'; 
                next_state <= st5; 
            WHEN st5 =>
                s_out <= '0'; 
                next_state <= idle; 
        END CASE;
    END PROCESS comb_p;
END behavioral;