# LFSR_Histogram_Binning
 FPGA-based pseudo-random number generator using LFSR with AXI4 interface and real-time histogram binning logic. Verified via Vivado simulation and IP integration.

# LFSR_Histogram_Binning

This project implements a Verilog-based Linear Feedback Shift Register (LFSR) for pseudo-random number generation on an FPGA, with on-chip histogram binning and AXI4 interface integration.

## Overview

- **LFSR Generator**: Generates pseudo-random 8-bit numbers with configurable taps.
- **AXI4-Lite Interface**: Enables external control and configuration.
- **AXI4-Stream Output**: Transmits data continuously to downstream modules.
- **Histogram Binning Logic**: Tally incoming values into frequency bins.
- **Vivado Simulation & Synthesis**: Verified using testbenches and waveform analysis.

## Features

- Modular Verilog design for ease of reuse and testing.
- Supports 16/32-bin histogram mapping.
- Clean AXI interface abstraction.
- Testbench-based validation of output randomness and binning correctness.

## Tools & Technologies

- Verilog HDL
- Xilinx Vivado + IP Integrator
- AXI4-Lite and AXI4-Stream Protocols
- GTKWave
- Artix-7 (Nexys 4 FPGA)


