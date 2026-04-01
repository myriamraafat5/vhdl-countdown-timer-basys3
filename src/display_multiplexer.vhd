----------------------------------------------------------------------------------
-- Company: University of Essex
-- Design Name:    Assignment1
-- Module Name:    display_multiplexer - Behavioral 
-- Description:    This is the multiplexer that choses wich 7 segment display should display which digit.
--                 It also switches between all displays giving the illusion that all displays are working at the same time but in reality it is multiplexed.
-- Dependencies:
-- References:     https://www.fypsolutions.com/fpga/fpga-vhdl-7-segment-multiplexing/
--                 https://github.com/otaviocmaciel/7-segment-VHDL
--                 https://www.vhdl-online.de/vhdl_workshop/lab_3
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_mux is
    Port ( clk_in     : in  STD_LOGIC; -- clock from the clock divider
           pulse_mux  : in  STD_LOGIC; -- pulse to switch from one display to another (clock divider)
           bcd_digits : in  STD_LOGIC_VECTOR(15 downto 0); -- the 4 digits to display
           bcd_out    : out STD_LOGIC_VECTOR(3 downto 0); --selected digit
           an_out     : out STD_LOGIC_VECTOR(3 downto 0) --selected display
           );
end display_mux;

architecture Behavioral of display_mux is

    signal digit_select : INTEGER range 0 to 3 := 0; -- counter to determine which digit am i displaying on the 7 segment
    
begin

    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if pulse_mux = '1' then
                if digit_select = 3 then
                    digit_select <= 0;
                else
                    digit_select <= digit_select + 1;
                end if;
            end if;
        end if;
    end process;
-- this process assigns the digit number to the bdc_digit by assigning from LSB to MSB where the 4 LSB are assigned to the digit selected 0
    process(digit_select, bcd_digits)
    begin
        case digit_select is
            when 0 => bcd_out <= bcd_digits(3 downto 0);
            when 1 => bcd_out <= bcd_digits(7 downto 4);
            when 2 => bcd_out <= bcd_digits(11 downto 8);
            when 3 => bcd_out <= bcd_digits(15 downto 12);
            when others => bcd_out <= (others => '0');
        end case;
    end process;
-- which 7 segment of the available 4 should be displaying
    process(digit_select)
    begin
        case digit_select is
            when 0 => an_out <= "1110";
            when 1 => an_out <= "1101";
            when 2 => an_out <= "1011";
            when 3 => an_out <= "0111";
            when others => an_out <= "1111";
        end case;
    end process;

end Behavioral;