module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
reg [3:0] q_reg;
always @(posedge clk)begin
    if(reset)begin
        q_reg <= 0;
    end
    else if(q_reg < 9) begin
        q_reg <= q_reg + 1;
    end
    else begin
        q_reg <= 0;
    end
end
assign q = q_reg;
endmodule