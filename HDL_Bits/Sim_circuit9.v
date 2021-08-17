module top_module (
    input clk,
    input a,
    output [3:0] q );
reg [3:0] q_reg;

always @(posedge clk)begin
    if(a)begin
        q_reg <= 4'd4;
    end
    else if(q_reg == 4'd6) begin
        q_reg <= 4'b0;
    end
    else begin
        q_reg <= q_reg + 1'b1;
    end
end

assign q = q_reg;
endmodule
