module top_module (
    input clk,
    input d,
    output q
);
reg q_reg_up;
reg q_reg_down;


always @(negedge clk)begin
    q_reg_down <= d;
end

always @(posedge clk) begin
    q_reg_up <= d;
end


assign q = clk ? q_reg_up : q_reg_down;
endmodule