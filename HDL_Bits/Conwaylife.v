module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
reg [3:0] row;
reg [3:0] col;
reg [3:0] sum;
reg [3:0] a;
reg [3:0] b;
reg [3:0] c;
reg [3:0] d;
reg [255:0] q_reg;
integer i;

always @(posedge clk)begin
    if(load)begin
        row <= 4'b0;
        col <= 4'b0;
        q_reg <= data;
    end
    else begin
        for(i = 0; i < 256;i = i + 1)begin
            row = i >> 4;
            col = i % 16;
            a = col + 1'b1;
            b = col - 1'b1;
            c = row + 1'b1;
            d = row - 1'b1;
            sum = q_reg[row * 16 + b] + q_reg[row * 16  + a] + q_reg[c * 16 + col]
            + q_reg[d * 16 + col] + q_reg[c * 16 + b] + q_reg[c * 16 + a]
            + q_reg[d * 16 + b] + q_reg[(d * 16 + a)];
            case (sum)
                4'd2: q_reg[i] <= q_reg[i];
                4'd3: q_reg[i] <= 1'b1; 
                default:q_reg <= 1'b0; 
            endcase
        end
    end
end

assign q = q_reg;
// always@(posedge clk)begin
//         if(load)begin
//             q_reg <= data;
//         end
//         else begin
//             for(i = 0; i <= 255; i = i + 1)begin
//                 if(i == 0)begin
//                     sum = q_reg[255] + q_reg[240] + q_reg[241] + q_reg[15] + q_reg[1] + q_reg[31] + q_reg[16] + q_reg[17];
//                 end
//                 else if(i == 15)begin
//                     sum = q_reg[254] + q_reg[255] + q_reg[240] + q_reg[14] + q_reg[0] + q_reg[30] + q_reg[31] + q_reg[16];
//                 end
//                 else if(i == 240)begin
//                     sum = q_reg[239] + q_reg[224] + q_reg[225] + q_reg[255] + q_reg[241] + q_reg[15] + q_reg[0] + q_reg[1];
//                 end
//                 else if(i == 255)begin
//                     sum = q_reg[238] + q_reg[239] + q_reg[224] + q_reg[254] + q_reg[240] + q_reg[14] + q_reg[15] + q_reg[0];
//                 end
//                 else if(i > 0 && i < 15)begin
//                     sum = q_reg[i + 239] + q_reg[i + 240] + q_reg[i + 241] + q_reg[i - 1] + q_reg[i + 1] + q_reg[i + 15] + q_reg[i + 16] + q_reg[i + 17];
//                 end
//                 else if(i > 240 && i < 255)begin
//                     sum = q_reg[i -17] + q_reg[i - 16] + q_reg[i - 15] + q_reg[i - 1] + q_reg[i + 1] + q_reg[i - 241] + q_reg[i - 240] + q_reg[i - 239];
//                 end
//                 else if(i % 16 == 0)begin
//                     sum = q_reg[i -1] + q_reg[i - 16] + q_reg[i - 15] + q_reg[i + 15] + q_reg[i + 1] + q_reg[i + 31] + q_reg[i + 16] + q_reg[i + 17];
//                 end
//                 else if(i % 16 == 15)begin
//                     sum = q_reg[i -17] + q_reg[i - 16] + q_reg[i - 31] + q_reg[i - 1] + q_reg[i - 15] + q_reg[i + 15] + q_reg[i + 16] + q_reg[i + 1];
//                 end
//                 else begin
//                     sum = q_reg[i - 17] + q_reg[i - 16] + q_reg[i - 15] + q_reg[i - 1] + q_reg[i + 1] + q_reg[i + 15] + q_reg[i + 16] + q_reg[i + 17];
//                 end
//                 case(sum)
//                     4'd2:begin
//                         q_reg[i] <= q_reg[i];
//                     end
//                     4'd3:begin
//                         q_reg[i] <= 1'b1;
//                     end
//                     default:begin
//                         q_reg[i] <= 1'b0;
//                     end
//                 endcase
//             end
//         end
//     end 

 
endmodule