module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    reg [15:0] q_reg;

always @(posedge clk)begin
    if(reset)begin
        q_reg[3:0] <= 0; 
    end
    else if(q_reg[3:0] < 9) begin
        q_reg[3:0] <= q_reg[3:0] + 1'b1;
    end
    else if (q_reg[3:0] == 9) begin
        q_reg[3:0] <= 1'b0;
    end
    else begin
        q_reg[3:0] <= q_reg[3:0];
    end
end

always @(posedge clk)begin
    if(reset)begin
        q_reg[7:4] <= 0;
    end
    else if(q_reg[7:4] < 9 && ena[1] == 1'b1) begin
        q_reg[7:4] <= q_reg[7:4] + 1'b1;
    end
    else if (q_reg[3:0] == 9 && ena[1] == 1'b1) begin
        q_reg[7:4] <= 1'b0;
    end
    else begin
        q_reg[7:4] <= q_reg[7:4];
    end
end

always @(posedge clk)begin
    if(reset)begin
        q_reg[11:8] <= 0; 
    end
    else if(q_reg[11:8] < 9 && ena[2] == 1'b1 && ena[1] == 1'b1) begin
        q_reg[11:8] <= q_reg[11:8] + 1'b1;
    end
    else if (q_reg[11:8] == 9 && ena[2] == 1'b1 && ena[1] == 1'b1) begin
        q_reg[11:8] <= 1'b0;
    end
    else begin
        q_reg[11:8] <= q_reg[11:8];
    end
end

always @(posedge clk)begin
    if(reset)begin
        q_reg[15:12] <= 0; 
    end
    else if(q_reg[15:12] < 9 && ena[3] == 1'b1 && ena[2] == 1'b1 && ena[1] == 1'b1) begin
        q_reg[15:12] <= q_reg[15:12] + 1'b1;
    end
    else if (q_reg[15:12] == 9 && ena[3] == 1'b1 && ena[2] == 1'b1 && ena[1] == 1'b1) begin
        q_reg[15:12] <= 1'b0;
    end
    else begin
        q_reg[15:12] <= q_reg[15:12];
    end
end

assign q = q_reg;
assign ena = {q_reg[11:8] == 9 && q_reg[7:4] == 9 && q_reg[3:0] == 9,q_reg[7:4] == 9 &&q_reg[3:0] == 9,q_reg[3:0] == 9};
endmodule