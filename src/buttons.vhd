----------------------------------------------------------------------------------
-- Company: University of Essex
-- Design Name:    Assignment1
-- Module Name:    buttons - Behavioral
-- Description:    This module explains how the button works, including debouncing and tracking the stable version of the button.
--                 It also includes the conversion of the button press into a pulse signal
-- Dependencies:  
-- References:     https://www.fpga4student.com/2017/08/vhdl-code-for-debouncing-buttons-on-fpga.html
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity buttons is
    Port (
        clk         : in  STD_LOGIC;
        btn_center  : in  STD_LOGIC;
        btn_up      : in  STD_LOGIC;
        btn_down    : in  STD_LOGIC;
        pulse_center: out STD_LOGIC;
        pulse_up    : out STD_LOGIC;
        pulse_down  : out STD_LOGIC
    );
end buttons;

architecture Behavioral of buttons is
    -- filtered: for holding debouncing of the button 
    -- previous: stores the previous state of the filtered (debounce) button.
    --      used for edge detecrion in order to have 1 pulse per button press 
    -- counter: counts how many cycles passed. if 100,000 passed, aka 1ms, accept the new button value
    signal center_filtered, center_prev : STD_LOGIC := '1'; 
    signal up_filtered, up_prev : STD_LOGIC := '1';
    signal down_filtered, down_prev : STD_LOGIC := '1';
    signal counter_center, counter_up, counter_down : integer range 0 to 100000 := 0;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            -- Center button debounce
            if btn_center = center_filtered then
                counter_center <= 0;
            else
                counter_center <= counter_center + 1;
                if counter_center = 100000 then
                    center_filtered <= btn_center;
                    counter_center <= 0;
                end if;
            end if;

            -- Up button debounce
            if btn_up = up_filtered then
                counter_up <= 0;
            else
                counter_up <= counter_up + 1;
                if counter_up = 100000 then
                    up_filtered <= btn_up;
                    counter_up <= 0;
                end if;
            end if;

            -- Down button debounce
            if btn_down = down_filtered then
                counter_down <= 0;
            else
                counter_down <= counter_down + 1;
                if counter_down = 100000 then
                    down_filtered <= btn_down;
                    counter_down <= 0;
                end if;
            end if;
        end if;
    end process;

    -- Generate single pulse on button press
    process(clk)
    begin
        if rising_edge(clk) then
            -- Center
            pulse_center <= '0';
            if center_prev = '1' and center_filtered = '0' then
                pulse_center <= '1';
            end if;
            center_prev <= center_filtered;

            -- Up
            pulse_up <= '0';
            if up_prev = '1' and up_filtered = '0' then
                pulse_up <= '1';
            end if;
            up_prev <= up_filtered;

            -- Down
            pulse_down <= '0';
            if down_prev = '1' and down_filtered = '0' then
                pulse_down <= '1';
            end if;
            down_prev <= down_filtered;
        end if;
    end process;

end Behavioral;
