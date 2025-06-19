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

//A 50 MHz clock is generated (20 time units period).
//Required for synchronous logic in the multiplier.


