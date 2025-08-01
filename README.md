# LFSR_Histogram_Binning
 FPGA-based pseudo-random number generator using LFSR with AXI4 interface and real-time histogram binning logic. Verified via Vivado simulation and IP integration.

# Description

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


# WISHBONE (Communication is Key!):
  
   uses master slave protocol
   master gives command and passes communication
   slave says whether its ready or not and validates the given signal
   CPU - Peripheral communication
   exchange data between ip core models

example for wishbone is caravel SoC

bridge : interconnections that allow data  exchange between two or more busses
wrapper : element of circuit to convert non-wishbone ip core to wishbone compatible ip core

wishbone protocol ensure efficient standard for interconnecting hardware components within system on chip

when slave responds to a given signal the master gives acknowledgmenet

# AXI:

   Widely used protocol(designed by arm)
   Supports highspeed data transfer and multiple transaction simultaneously
   AXI,AXI-Lite,AXI-Stream
   performance , area reduced, power reduced,etc
   during read cycles - master recieves a signal from slave only while reading data
    during write cycles - master recieves a signal from slave only for doing write response

axi stream is a point to point protocol
it is fully handshaked


# CHI:
  coherent hub interface
  Coherency : ensures same data in all copies of that specific memory address
  Consistency : Memory updates happen in same order.

cache stores copies of freq accessed data

ensures coherent communication in multicore processor
supports large advanced memory architechture
encures coherency
MOESI Cache coherency
CHI suppoerts large number of cores and large bandwidth


##Histogram Module with AXI-Stream RAM

### Debugging and Fixes

- s_m_hist Module
  - Fixed syntax errors and binning logic
  - Ensured correct bin count updates

- axi_ram Module
  - Designed AXI-Stream RAM for histogram bin data storage
  - Address mapping for bin counts and LFSR-generated values
  - Fixed width and syntax issues

### Testbench Development

- Created dedicated testbenches for s_m_hist and axi_ram
- Verified data transfer correctness through waveform analysis
- Resolved output mismatches

### Simulation and Results Verification

- Verified bin mappings and memory storage against expected outcomes
- Cross-checked waveform behavior

### AXI Integration

- Verified AXI-Stream handshake signals:
  - m_axis_tvalid, m_axis_tdata, s_axis_tready, s_axis_tvalid
- Discussed and validated AXI-Slave interface alignment with system needs

---

## 👨‍💻 Author

Manal Ahmed  
[NIT Karnataka, ECE]

---

### 🔗 License

This project is licensed under the MIT License. See `LICENSE` file for details.

  



