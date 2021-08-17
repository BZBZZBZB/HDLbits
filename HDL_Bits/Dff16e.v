module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
reg [15:0] q_reg;

always @(posedge clk)begin
    if(~resetn)begin
        q_reg <= 0;
    end
    else if(byteena[0] && byteena[1]) begin
        q_reg <= d; 
    end
    else if(byteena[1])begin
        q_reg[15:8] <= d[15:8];
    end
    else if(byteena[0])begin
        q_reg[7:0] <= d[7:0];
    end
    else begin
        q_reg <= q_reg;
    end
end

assign q = q_reg;
endmodule