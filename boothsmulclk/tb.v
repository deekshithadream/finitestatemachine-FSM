module booths_multiplier_tb (); 
 
//input 
reg start, reset, clk; 
reg [7:0] a_in; 
reg [7:0] b_in; 
 
//output 
wire [15:0] r_out; 
wire ready; 
 
//instantiating the DUT 
booths_multiplier DUT (.start(start), 
.reset(reset), .clk(clk), .a_in(a_in), .b_in(b_in), 
.r_out(r_out), .ready(ready)); 
 
//generate clock 
initial 
    clk = 1'b0; 
 
always  
    #10 clk = ~clk; 
 
//initial block 1// 
/* 
dumpfile 
dumpvar 
monitor 
*/ 
initial  
begin 
    $dumpfile ("data.vcd"); 
    $dumpvars (0, booths_multiplier_tb); 
    $monitor("output = %h",r_out); 
end 
 
//initial block2// 
/* 
giving general stimulus 
*/ 
initial 
begin 
    a_in = 8'd03; 
    b_in = 8'd04; 
 
    reset = 1'b0;
        start = 1'b0; 
 
    #12 
    reset = 1'b1; 
    start = 1'b1; 
 
    #20 
    start = 1'b0; 
 
    #250 
    a_in = 8'd02; 
    b_in = 8'd04; 
    start = 1'b1; 
    #30 
    start = 1'b0; 
 
    #250 
    a_in = 8'd03; 
    b_in = 8'd03; 
    start = 1'b1; 
    #30 
    start = 1'b0; 
 
    #250 
    a_in = 8'd01; 
    b_in = 8'd02; 
    start = 1'b1; 
    #30 
    start = 1'b0; 
 
    #250 
    a_in = 8'd04; 
    b_in = 8'd03; 
    start = 1'b1; 
    #30 
    start = 1'b0; 
 
end 
initial 
#1550 $finish; 
endmodule 

//Multiple pairs of inputs are applied (like 3×4, 2×4, 3×3, etc.).
//Each multiplication:
//Waits a few cycles,
//Starts (start = 1),
//Then stops (start = 0),
//Waits enough time (~250 units) for the FSM to complete before starting the next
//a_in, b_in	Inputs to multiply
//r_out	Result of multiplication (8×8 → 16)
//$monitor	Logs output to console
//$dumpvars	Saves signals for waveform analysis