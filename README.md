# VHDL Countdown Timer — Basys3 FPGA

A settable countdown timer implemented in VHDL and deployed on a Digilent Basys3 FPGA board, displaying the remaining time on a 4-digit 7-segment display.

## Features
- Two modes of operation: **SET** and **GO**, toggled via the central button
- Set initial time in minutes (0–60) using up/down buttons
- Countdown at a rate of 2 seconds per tick
- Pause and resume functionality
- Modular VHDL design with separate components for each function

## Hardware
- Digilent Basys3 (Xilinx Artix-7 FPGA)
- Xilinx Vivado Design Suite

## Project Structure
```
├── src/
│   ├── main1_final.vhd         # Top-level design
│   ├── bcd_to_7seg.vhd         # BCD to 7-segment decoder
│   ├── buttons.vhd             # Button debounce and input handling
│   ├── clock_divider.vhd       # Clock divider for 2s tick
│   ├── countdown.vhd           # Countdown logic
│   ├── display_multiplexer.vhd # Time-multiplexed display driver
│   └── multiplexer.vhd         # General purpose multiplexer
├── constraints/
│   └── basys3.xdc              # Pin constraints for Basys3
└── main_file.xpr               # Vivado project file
```

