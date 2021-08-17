module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
reg [31:0] in_reg;
reg [31:0] out_reg;
integer i;
always @(posedge clk) begin
    in_reg <= in;
end

always @(posedge clk) begin
    if(reset)begin
        out_reg <= 0;
    end
    else begin
        for(i = 0; i < 32;i = i + 1)begin
            if(~in[i] && in_reg[i])begin
                out_reg[i] <= 1;
            end
            else begin
                out_reg[i] <= out_reg[i];
            end   
        end
    end
end
assign out = out_reg;
endmodule