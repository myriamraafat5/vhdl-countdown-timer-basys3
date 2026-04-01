----------------------------------------------------------------------------------
-- Company: University of Essex
-- Design Name:    Assignment1
-- Module Name:    bcd_to_7seg - Behavioral
<<<<<<< HEAD
-- Description:   This module includes the logioc of the 7 segment display, where it 
--                translates inputs to numbers
-- Dependencies:
-- References:    https://allaboutfpga.com/bcd-to-7-segment-decoder-vhdl-code/
=======
-- Description:    dummy design allowing students to familiarize with pinout
--                 and polarity of the Basys3 7-segment display designed
--                 for time-multiplexing
-- Dependencies:   https://allaboutfpga.com/bcd-to-7-segment-decoder-vhdl-code/
>>>>>>> origin/master
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

<<<<<<< HEAD
=======

>>>>>>> origin/master
entity bcd_to_7seg is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is
begin
    process(x)
    begin
        case x is
            when "0000" => seg <= "1000000"; -- display 0
            when "0001" => seg <= "1111001"; -- display 1
            when "0010" => seg <= "0100100"; -- display 2
            when "0011" => seg <= "0110000"; -- display 3
            when "0100" => seg <= "0011001"; -- display 4
            when "0101" => seg <= "0010010"; -- display 5
            when "0110" => seg <= "0000010"; -- display 6
            when "0111" => seg <= "1111000"; -- display 7
            when "1000" => seg <= "0000000"; -- display 8
            when "1001" => seg <= "0010000"; -- display 9
            when others => seg <= "1111111"; -- display null 
        end case;
    end process;           
end Behavioral;
