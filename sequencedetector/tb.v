module seq_gen_tb; 
 
reg clk; 
reg reset; 
wire [7:0] seq_out; 
 
seq_gen dut( 
    .clk(clk), 
    .reset(reset), 
    .seq_out(seq_out));
    initial begin 
    clk = 0; 
    reset = 1; 
    #10 reset = 0; 
    #100 $finish; 
end 
 
always #5 clk = ~clk; 
 
endmodule

//This testbench is used to simulate and verify the working of the seq_gen module by applying clock and
// reset signals and observing the output (seq_out).

