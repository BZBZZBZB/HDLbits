module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
wire [513:0] data_actually;
reg [511:0] q_reg;
integer i;

always @(posedge clk)begin
    if(load)begin
        q_reg <= data;
    end
    else begin
        for(i = 0; i < 512;i = i + 1)begin
            q_reg[i] <= ((~data_actually[i+2] && data_actually[i+1]) || (data_actually[i + 1] && ~data_actually[i])
            || (~data_actually[i+2] && data_actually[i]) || (~data_actually[i+1] && data_actually[i]));
        end
    end
end



assign q = q_reg;
assign data_actually = {1'b0,q_reg,1'b0};
endmodule