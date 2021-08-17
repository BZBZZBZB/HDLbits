module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
reg [31:0] q_reg;
// always @(posedge clk)begin
//     if(reset)begin
//         q_reg <= 32'h1;
//     end
//     else begin
//         q_reg[31] <= q_reg[0];
//         q_reg[21] <= q_reg[22] ^ q_reg[0];
//         q_reg[1] <= q_reg[2] ^ q_reg[0];
//         q_reg[0] <= q_reg[1] ^ q_reg[0];
//         q_reg[30:22] <= q_reg[30:22];
//         q_reg[20:2] <= q_reg[20:2];
//     end
// end
// assign q = q_reg;


    reg [31:0]	q_next;
    always@(*)begin
        q_next = {q[0], q[31:1]};
        q_next[21] = q[0] ^ q[22];
        q_next[1] = q[0] ^ q[2];
        q_next[0] = q[0] ^ q[1];
    end
    
    always@(posedge clk)begin
        if(reset)begin
            q_reg <= 32'd1;
        end
        else begin
            q_reg <= q_next;
        end
    end
    assign q = q_reg;
endmodule 