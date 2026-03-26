library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity stw is
    port (--start : in STD_LOGIC; 
        reset : in std_logic;
        --resum : in STD_LOGIC; 
        clk : in std_logic;
        h_tick, m_tick, s_tick : out std_logic_vector(5 downto 0);
        mili_s : out std_logic_vector(6 downto 0));
end entity;

architecture bhv of stw is

    --CONSTANT max_count1 : integer := 499_999; --for clock division.
    constant max_count1 : integer := 1; --for clock division.
    constant max_count2 : integer := 100; --for mod 100 counter. 
    subtype counter_type1 is integer range 0 to max_count1;
    subtype counter_type2 is integer range 0 to 60;
    signal clk_out : std_logic := '0'; --100 Hz clock derived from the 100MHz 
    signal h_ticki, m_ticki, s_ticki : counter_type2 := 0;
    signal mili_si : counter_type1 := 0;
begin

    --the following process divides the clock into 100hz to run the milisecond counter. 
    --clock division process 
    clk_div : process (clk)
        variable cnt1 : counter_type1 := 0;
    begin
        if RISING_EDGE(clk) then
            if reset = '1' then
                clk_out <= '0';
                cnt1 := 0;
            else
                if cnt1 = max_count1 then
                    clk_out <= not clk_out;
                    cnt1 := 0;
                else
                    cnt1 := cnt1 + 1;
                end if;
            end if;
        end if;
    end process clk_div;

    --mode 100 counter with 100Hz frequency 
    m100_counter : process (clk_out)
    begin
        if RISING_EDGE(clk_out) then
            if reset = '1' then
                mili_si <= 0;
            else
                if mili_si = 99 then
                    mili_si <= 0;
                else
                    mili_si <= mili_si + 1;
                end if;
            end if;
        end if;
    end process m100_counter;

    --second hand movement 
    sec_hand : process (mili_si, reset)
        variable sec_count : counter_type2 := 0;
    begin
        if reset = '1' then
            s_ticki <= 0;
            m_ticki <= 0;
            h_ticki <= 0;
        else
            if mili_si = 0 then
                s_ticki <= s_ticki + 1;
                if s_ticki = 59 then
                    s_ticki <= 0;
                    m_ticki <= m_ticki + 1;
                    if m_ticki = 59 then
                        m_ticki <= 0;
                        h_ticki <= h_ticki + 1;
                        if h_ticki = 23 then
                            h_ticki <= 0;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process sec_hand;

    mili_s <= std_logic_vector(TO_UNSIGNED(mili_si, mili_s'LENGTH));
    s_tick <= std_logic_vector(TO_UNSIGNED(s_ticki, s_tick'LENGTH));
    m_tick <= std_logic_vector(TO_UNSIGNED(m_ticki, m_tick'LENGTH));
    h_tick <= std_logic_vector(TO_UNSIGNED(h_ticki, h_tick'LENGTH));

end bhv;