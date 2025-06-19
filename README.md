# finitestatemachine-FSM
# booths multiplier using clk gating
Multiplication type	=Signed 8×8
Algorithm	=  Booth's
Optimized with	=Clock gating
FSM states	=idle, add, shift
Registers updated on	=Negative edge of gated clock
Output (r_out)=	Concatenation of A and Q
ready signal  =High when FSM returns to idle

booths multiplier using clk gating:Here's a Booth's Multiplier implementation using clock gating in Verilog, similar to the one from your previous code. This version saves power by disabling the clock to data path elements when they are not needed

# booths multiplier using one hot coding

Component          Description                                                                 
FSM                Uses one-hot encoding: `IDLE`, `ADD`, `SHIFT`                               
Booth Logic        Adds or subtracts `M` from `A` based on `{Q[0], q}`                         
Shift Logic        Arithmetic right shift of `{A, Q, q}` to preserve sign                      
Counter            4-bit counter `n` tracks the 8 clock cycles needed                          
Control           `start` begins multiplication; `ready` goes high when operation is complete 
Output            `r_out = {A, Q}` — final 16-bit signed product                            

