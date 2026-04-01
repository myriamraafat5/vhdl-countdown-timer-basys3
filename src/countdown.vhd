----------------------------------------------------------------------------------
-- Company: University of Essex
-- Design Name:    Assignment1
-- Module Name:    countdown - Behavioral
-- Description:    This is the countdown of the 2 digit minutes and 2 digit seconds.
--                 It shows how they work in both "SET" and "GO" modes
-- Dependencies:   
-- References:     https://vhdlwhiz.com/create-timer/
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity countdown is
    Port (
        clk          : in  STD_LOGIC;
        pulse_center : in  STD_LOGIC;
        pulse_up     : in  STD_LOGIC;
        pulse_down   : in  STD_LOGIC;
        pulse_2s     : in  STD_LOGIC;   -- 2 second pulse from clock divider
        min_tens     : out STD_LOGIC_VECTOR(3 downto 0);
        min_ones     : out STD_LOGIC_VECTOR(3 downto 0);
        sec_tens     : out STD_LOGIC_VECTOR(3 downto 0);
        sec_ones     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end countdown;

architecture Behavioral of countdown is
    signal minutes   : integer range 0 to 60 := 0;
    signal seconds   : integer range 0 to 59 := 0;
    signal mode_set  : STD_LOGIC := '1';  -- '1' = SET, '0' = GO
    signal pulse_prev : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Toggle between SET and GO mode
            if pulse_center = '1' then
                mode_set <= not mode_set;
            end if;

            if mode_set = '1' then
                -- SET mode for adjusting minutes
                if pulse_up = '1' and minutes < 60 then
                    minutes <= minutes + 1;
                    seconds <= 0;
                elsif pulse_down = '1' and minutes > 0 then
                    minutes <= minutes - 1;
                    seconds <= 0;
                end if;
            else
                -- GO mode fir countdown every 2 seconds
                if pulse_2s = '1' then
                    if seconds = 0 then
                        if minutes > 0 then
                            minutes <= minutes - 1;
                            seconds <= 59;
                        end if;
                    else
                        seconds <= seconds - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Convert minutes and seconds to BCD for display
    min_tens <= std_logic_vector(to_unsigned(minutes / 10, 4));
    min_ones <= std_logic_vector(to_unsigned(minutes mod 10, 4));
    sec_tens <= std_logic_vector(to_unsigned(seconds / 10, 4));
    sec_ones <= std_logic_vector(to_unsigned(seconds mod 10, 4));

end Behavioral;