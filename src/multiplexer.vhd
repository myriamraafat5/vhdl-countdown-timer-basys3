----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2026 17:03:43
-- Design Name: 
-- Module Name: multiplexer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplexer is
    Port (
        clk         : in  STD_LOGIC;
        pulse_mux   : in  STD_LOGIC;               -- 1kHz pulse for multiplexing
        min_tens    : in  STD_LOGIC_VECTOR(3 downto 0);
        min_ones    : in  STD_LOGIC_VECTOR(3 downto 0);
        sec_tens    : in  STD_LOGIC_VECTOR(3 downto 0);
        sec_ones    : in  STD_LOGIC_VECTOR(3 downto 0);
        seg         : out STD_LOGIC_VECTOR(6 downto 0);
        an          : out STD_LOGIC_VECTOR(3 downto 0) -- 4 digits for multiplexing
    );
end multiplexer;

architecture Behavioral of multiplexer is
    signal digit_select : integer range 0 to 3 := 0;  -- Counter for selecting digits
begin
    -- Multiplexing process for 7-segment display
    process(clk)
    begin
        if rising_edge(clk) then
            if pulse_mux = '1' then  -- When the 1kHz pulse is high
                case digit_select is
                    when 0 =>
                        an <= "1110";  -- Enable 1st digit (min_tens)
                        bcd_to_7seg_inst: bcd_to_7seg
                            Port map (x => min_tens, seg => seg);
                    when 1 =>
                        an <= "1101";  -- Enable 2nd digit (min_ones)
                        bcd_to_7seg_inst: bcd_to_7seg
                            Port map (x => min_ones, seg => seg);
                    when 2 =>
                        an <= "1011";  -- Enable 3rd digit (sec_tens)
                        bcd_to_7seg_inst: bcd_to_7seg
                            Port map (x => sec_tens, seg => seg);
                    when 3 =>
                        an <= "0111";  -- Enable 4th digit (sec_ones)
                        bcd_to_7seg_inst: bcd_to_7seg
                            Port map (x => sec_ones, seg => seg);
                    when others =>
                        an <= "1111";  -- Disable all digits
                end case;
                
                -- Increment digit select to go to the next digit
                digit_select := (digit_select + 1) mod 4;  -- Wrap around after 4 digits
            end if;
        end if;
    end process;

end Behavioral;