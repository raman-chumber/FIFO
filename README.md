# FIFO
Designed, validated and synthesized a parameterized first-in first-out buffer in Verilog. An asynchronous buffer that transmits data from one clock domain to another with different frequencies and various design specifications such as empty and full flag conditions designed in Verilog.

# Objective of the Project
The objective of this project is to design, validate and synthesize a parameterized first-in first-out (FIFO) buffer in Verilog. The default depth of the FIFO is 128 32-bit words. It supports flush, insert, and remove operations. During the insert operation, a new word is added to the tail (end) of the buffer and an internal write pointer is incremented on positive edge of clk_in clock. The data at the head of the FIFO is read during the remove operation, and an internal read pointer is incremented on positive edge clk_out clock. A flush clears all words in the buffer. The buffer is considered empty after a flush. Here are the ports for the FIFO:
• 1-bit input reset: An asynchronous global system reset. Every sequential element in the system goes through a reset when this signal is asserted. The content of the FIFO is cleared. The status of the FIFO will be empty after a reset.
• 1-bit input flush: When asserted, the FIFO is cleared, and the read/write pointers are reset on positive edge of clock clk_in. The FIFO status is empty.
• 1-bit input insert: When asserted, data on data_in port is stored at the tail of the FIFO on positive edge of clock clk_in
• 1-bit input remove: When asserted, data at the head of the FIFO is removed from the FIFO and is placed on the on the data_out output port on positive edge of clk_out
• 32-bit input data_in: input data port
• 32-bit output data_out: output data port
• 1-bit output full: asserted on the positive edge of clk_in clock when the buffer is full and there is
no more room for data
• 1-bit output empty: asserted on the positive edge of clk_out clock when the buffer is empty (no
data in the buffer)

# Project Phases
# 1. Design
Your design must support the features stated above. You should consider time and area efficiency in your design. Use FSMs where appropriate. The design requires two out-of-phase clocks. clk_in is twice as fast as clk_out. It is important to use synchronizers when signals cross clock domains.
               
# 2. Verification
You should develop a test fixture that can validate the FIFO using the automated verification techniques discussed in the course. You need to rely on code coverage to assess the extent of your verification.
# 3. Synthesis
You must synthesize your final design using 90nm technology library provided by Synopsys. Apply 0.3 ns and 0.4 as maximum and minimum delays to all ports. You must change the design to address any potential synthesis error and violation. Your report must include attempts for improving synthesis results through revising the design.

# Block Diagram of FIFO

<img width="909" alt="Screenshot 2019-06-19 16 14 46" src="https://user-images.githubusercontent.com/35642629/59807728-00fc2480-92ae-11e9-8fbc-76aab0cdd89b.png">

# Write fsm moore model
RESET_ST : when we assert flush and reset 
WRITE : for writing into the fifo
IDLE : initial state

<img width="987" alt="Screenshot 2019-06-19 16 33 06" src="https://user-images.githubusercontent.com/35642629/59808192-0fe3d680-92b0-11e9-9d27-aa542aab0ec9.png">

# Read fsm moore model
RESET_ST : when we assert flush and reset
READ : for reading from the fifo
IDLE : initial state

<img width="939" alt="Screenshot 2019-06-19 16 35 26" src="https://user-images.githubusercontent.com/35642629/59808270-7832b800-92b0-11e9-90da-921fc8ae6115.png">

# Block Diagram for Test Bench

<img width="805" alt="Screenshot 2019-06-19 16 40 21" src="https://user-images.githubusercontent.com/35642629/59808438-16268280-92b1-11e9-844e-12219806987b.png">


