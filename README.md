# Tang Nano 9K - Physical AND Gate Implementation

This project demonstrates a basic **AND gate** implementation using the onboard user buttons of the Tang Nano 9K FPGA. It covers essential digital design concepts such as I/O management, voltage bank constraints, active-low logic, and hardware verification using a logic analyzer.

## 🛠 Hardware Setup
- **FPGA:** Gowin Tang Nano 9K
- **Inputs:** 
  - **S1 Button:** Pin 3 (Bank 3 - 1.8V)
  - **S2 Button:** Pin 4 (Bank 3 - 1.8V)
- **Output:** 
  - **Pin 70:** 3.3V Logic Output for signal tracing and verification.
- **Verification Tools:** 24MHz Logic Analyzer & PulseView software.

## 🧠 Technical Insights & Lessons Learned

### 1. Active-Low Button Logic
On the Tang Nano 9K, the onboard user buttons (S1/S2) follow an **Active-Low** architecture:
- **Released State:** The pin reads logic `1`.
- **Pressed State:** The pin reads logic `0`.
To implement a standard AND gate logic (where the output is `1` only when both buttons are pressed), the input signals are inverted within the Verilog code using the bitwise NOT (`~`) operator.

### 2. Physical Constraints (CST) Explanation
The `.cst` file is crucial for mapping the Verilog signals to the physical pins of the FPGA. Below is an explanation of the constraints used in this project:

*   **`IO_LOC "btn1" 3;`**: Maps the `btn1` signal to physical Pin 3 on the FPGA package.
*   **`IO_PORT "btn1" IO_TYPE=LVCMOS18;`**: Defines the I/O standard for Pin 3. Since Bank 3 is hardwired to 1.8V, we must use `LVCMOS18`. Using `LVCMOS33` here would cause a voltage bank conflict.
*   **`IO_LOC "out_pin" 70;`**: Maps the `out_pin` signal to physical Pin 70.
*   **`IO_PORT "out_pin" IO_TYPE=LVCMOS33;`**: Sets the output voltage to 3.3V. This demonstrates the FPGA's ability to drive a 3.3V signal even when the inputs are 1.8V.

### 3. Level Shifting Capability
This project showcases the FPGA's capability to act as a **Level Shifter**. The internal I/O buffers translate the **1.8V** input signals from Bank 3 into a **3.3V** output on Pin 70. This demonstrates how an FPGA can seamlessly interface between components operating at different voltage levels.

## 🔍 Signal Analysis & Verification
The design was physically verified using a logic analyzer. A 8 channel 24Mhz analyzer with Pulseview can do work.

**Key Observations:**
- **Switch Bounce:** Mechanical "bouncing" is clearly visible in the capture. Since no digital debouncing filter was implemented in this stage, every micro-contact during the press is reflected at the output.
- **Synchronization:** The output successfully maintains a stable logic `1` as long as both buttons are held down simultaneously, confirming the AND logic.

## 🚀 How to Run
1. Add the Verilog source code from the `/src` directory to your Gowin EDA project.
2. Apply the pin constraints provided in the `/src/tang_nano_9k.cst` file.
3. Synthesize, Place & Route, and program the generated `.fs` bitstream to the Tang Nano 9K.
4. Connect Pin 70 and GND to your Logic Analyzer to observe the real-time results.
