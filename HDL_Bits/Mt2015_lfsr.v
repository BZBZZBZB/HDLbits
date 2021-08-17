module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

reg [2:0] LEDR_reg;
always @(posedge KEY[0])begin
    if(KEY[1])begin
        LEDR_reg[0] <= SW[0];
        LEDR_reg[1] <= SW[1];
        LEDR_reg[2] <= SW[2];
    end
    else begin
        LEDR_reg[0] <= LEDR_reg[2];
        LEDR_reg[1] <= LEDR_reg[0];
        LEDR_reg[2] <= LEDR_reg[1] ^ LEDR_reg[2];
    end
end

assign LEDR = LEDR_reg;
endmodule