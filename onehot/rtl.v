module booths_multiplier( 
    input clk,              // clock 
    input reset,            // active low reset 
    input start,            // command to start 
multiplication 
    input [7:0] a_in,       // Multiplicand 
    input [7:0] b_in,       // Multiplier 
    output [15:0] r_out,    // Product    
    output ready            // Asserted when the 
multiplier is ready for a new request);
// One-hot encoded state parameters 
parameter IDLE  = 3'b001; 
parameter SHIFT = 3'b010; 
parameter ADD   = 3'b100; 
 
// State registers 
reg [2:0] state, state_next; 
 
always @(negedge clk or negedge reset) begin 
    if (~reset) 
        state <= IDLE; 
    else     
        state <= state_next; 
end 
 
// Data registers 
reg [7:0] Q, A, M; // Multiplicand, Accumulator, 
Multiplier 
reg q;             // Q[-1]     
reg [3:0] n;       // Bit width (number of 
iterations) 
reg [7:0] Q_next, A_next;     
reg q_next;           
reg [3:0] n_next;     
 
// Next state logic 
always @(*) begin 
    case (state) 
        IDLE: begin 
            if (start) 
                state_next = (a_in[0] ^ 1'b0) ? ADD : 
SHIFT; 
            else 
                state_next = IDLE; 
        end 
        SHIFT: begin 
            if (n_next == 4'b0) 
                state_next = IDLE; 
            else 
                state_next = (Q_next[0] ^ q_next) ? 
ADD : SHIFT; 
        end 
        ADD: begin 
            state_next = SHIFT; 
        end 
        default: state_next = IDLE; 
    endcase 
end 
 
// Output logic
assign ready = (state == IDLE); 
 
// Data path logic 
always @(negedge clk or negedge reset) begin 
    if (~reset) begin 
        Q <= 8'bx; 
        A <= 8'b0; 
        q <= 1'bx; 
        n <= 4'd8; 
    end else begin 
        Q <= Q_next; 
        A <= A_next; 
        q <= q_next; 
        n <= n_next; 
    end 
end 
 
// Data operations 
always @(*) begin 
    case (state) 
        IDLE: begin 
            if (start) begin 
                Q_next = a_in; 
                M = b_in; 
                A_next = 8'b0; 
                q_next = 1'b0; 
                n_next = 4'd8; 
            end 
        end 
        ADD: begin 
            if ({Q[0], q} == 2'b10) 
                A_next = A - M; 
            else  
                A_next = A + M; 
        end 
        SHIFT: begin 
            {A_next, Q_next, q_next} = {A[7], A, Q}; 
            n_next = n - 1; 
        end 
    endcase 
end 
 
// Assign output 
assign r_out = {A, Q}; 
endmodule

// This Verilog module is a Booth’s Multiplier implementation using a One-Hot Encoded Finite State Machine (FSM).
//FSM	        = Controls multiplier state (IDLE, ADD, SHIFT)
//Booth logic	= Adds or subtracts M from A based on Q[0], q
//Shift unit	= Arithmetic right shift of {A, Q, q}
//n counter	    = Tracks 8 iterations
//ready signal  =	Indicates module is ready for new operation
//Output	    = 16-bit result in r_out = {A, Q}
