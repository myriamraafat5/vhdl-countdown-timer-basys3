----------------------------------------------------------------------------------
-- Company: University of Essex
-- Design Name:    Assignment1
-- Module Name:    clock_divider - Behavioral
-- Description:    This module divides the clock giving 2 different pulses.
--                 1- 2s pulse for the countdown time 
--                 2- 1ms for the multiplexing of the 7 segment displays 
-- Dependencies:   
-- Reference:      https://allaboutfpga.com/vhdl-code-for-clock-divider/
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider is
    Port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_2s : out STD_LOGIC; --the pulse that happens every 2 secs
           pulse_mux : out STD_LOGIC); --the pulse that happens every 1ms for the multiplexing
end clock_divider;

architecture Behavioral of clock_divider is
    signal counter_2sec : unsigned (27 downto 0):= (others => '0');
    signal  counter_mux : unsigned (16 downto 0):= (others => '0');
    
begin

    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if reset = '1' then
                counter_2sec <= (others => '0');
                counter_mux <= (others => '0');
                pulse_2s <= '0';
                pulse_mux <= '0';
            else
                -- for the countdown numbers
                if counter_2sec = 199_999_999 then
                   counter_2sec <= (others =>'0');
                   pulse_2s <='1';
                else
                   counter_2sec <= counter_2sec + 1;
                   pulse_2s <='0';
                end if;
                
                --for the multiplexer
                if counter_mux = 99_999 then
                    counter_mux <=(others => '0');
                    pulse_mux <='1';
                else
                    counter_mux <= counter_mux + 1;
                    pulse_mux <= '0';
                end if;
             end if;
           end if;
     end process;
     
end Behavioral;
