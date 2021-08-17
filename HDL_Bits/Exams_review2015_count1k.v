module top_module (
    input clk,
    input reset,
    output [9:0] q);
reg [9:0] cnt;
always @(posedge clk)begin
    if(reset)begin
        cnt <= 10'b0;
    end
    else if(cnt == 10'd999) begin 
        cnt <= 10'b0;
    end
    else begin
        cnt <= cnt + 1'b1;
    end
end
assign q = cnt;
endmodule