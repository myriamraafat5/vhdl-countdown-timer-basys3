----------------------------------------------------------------------------------
-- Company: University of Essex
-- Design Name:    Assignment1
-- Module Name:    main1_final - Behavioral
-- Description:    This module combines between bcd_to_7seg, buttons, clock_divider, countdown, display_mux modules together in a top main code 
--                 showing how they are connected and how they function in order to get the final output.
-- Dependencies:   bcd_to_7seg, buttons, clock_divider, countdown, display_mux
-- References:     Lab3_2_1 , https://stackoverflow.com/questions/209458/concatenating-bits-in-vhdl
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main1_final is
    Port ( 
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        btn_center  : in  STD_LOGIC;
        btn_up      : in  STD_LOGIC;
        btn_down    : in  STD_LOGIC;
        seg         : out STD_LOGIC_VECTOR(6 downto 0);
        an_out      : out STD_LOGIC_VECTOR(3 downto 0)
    );
end main1_final;

architecture Behavioral of main1_final is

    -- signals connecting submodules
    signal pulse_center  : STD_LOGIC;
    signal pulse_up      : STD_LOGIC;
    signal pulse_down    : STD_LOGIC;
    signal pulse_2s      : STD_LOGIC;
    signal pulse_mux     : STD_LOGIC;
    signal min_tens      : STD_LOGIC_VECTOR(3 downto 0);
    signal min_ones      : STD_LOGIC_VECTOR(3 downto 0);
    signal sec_tens      : STD_LOGIC_VECTOR(3 downto 0);
    signal sec_ones      : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_digits    : STD_LOGIC_VECTOR(15 downto 0);
    signal bcd_out       : STD_LOGIC_VECTOR(3 downto 0);


    -- 1) component declarations
    component buttons
        Port (
            clk         : in  STD_LOGIC;
            btn_center  : in  STD_LOGIC;
            btn_up      : in  STD_LOGIC;
            btn_down    : in  STD_LOGIC;
            pulse_center: out STD_LOGIC;
            pulse_up    : out STD_LOGIC;
            pulse_down  : out STD_LOGIC
        );
    end component;

    component clock_divider
        Port (
            clk_in    : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            pulse_2s  : out STD_LOGIC;
            pulse_mux : out STD_LOGIC
        );
    end component;

    component countdown
        Port (
            clk          : in  STD_LOGIC;
            pulse_center : in  STD_LOGIC;
            pulse_up     : in  STD_LOGIC;
            pulse_down   : in  STD_LOGIC;
            pulse_2s     : in  STD_LOGIC;
            min_tens     : out STD_LOGIC_VECTOR(3 downto 0);
            min_ones     : out STD_LOGIC_VECTOR(3 downto 0);
            sec_tens     : out STD_LOGIC_VECTOR(3 downto 0);
            sec_ones     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component display_mux
        Port (
            clk_in      : in  STD_LOGIC;
            pulse_mux   : in  STD_LOGIC;
            bcd_digits  : in  STD_LOGIC_VECTOR(15 downto 0);
            bcd_out     : out STD_LOGIC_VECTOR(3 downto 0);
            an_out      : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component bcd_to_7seg
        Port (
            x   : in  STD_LOGIC_VECTOR(3 downto 0);
            seg : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

begin

    -- 2) cutton module port map
    buttonss: buttons
        port map (
            clk         => clk,
            btn_center  => btn_center,
            btn_up      => btn_up,
            btn_down    => btn_down,
            pulse_center=> pulse_center,
            pulse_up    => pulse_up,
            pulse_down  => pulse_down
        );

    -- 3) clock divider port map
    clock_dividerr: clock_divider
        port map (
            clk_in    => clk,
            reset     => reset,
            pulse_2s  => pulse_2s,
            pulse_mux => pulse_mux
        );

    -- 4) countdown timer port map
    countdownn: countdown
        port map (
            clk          => clk,
            pulse_center => pulse_center,
            pulse_up     => pulse_up,
            pulse_down   => pulse_down,
            pulse_2s     => pulse_2s,
            min_tens     => min_tens,
            min_ones     => min_ones,
            sec_tens     => sec_tens,
            sec_ones     => sec_ones
        );

    -- combine minutes and seconds into a 16-bit BCD vector
    bcd_digits <= min_tens & min_ones & sec_tens & sec_ones;

    -- 5) display multiplexer port map
    display_muxx: display_mux
        port map (
            clk_in     => clk,
            pulse_mux  => pulse_mux,
            bcd_digits => bcd_digits,
            bcd_out    => bcd_out,
            an_out     => an_out
        );

    -- 6) bcd to 7-segment display port map
    bcd_to_7segg: bcd_to_7seg
        port map (
            x   => bcd_out,
            seg => seg
        );

end Behavioral;

