module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);

reg [3:0] q_reg;

always @(posedge clk)begin
    if(shift_ena)begin
        q_reg <= {q[2:0],data};
    end
    else if (count_ena) begin
        q_reg <= q_reg - 1'b1;
    end
    else begin
        q_reg <= q_reg;
    end
end

assign q = q_reg;
endmodule