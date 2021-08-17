module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
reg [2:0] count;
reg [7:0] LUT;
wire [2:0] opt;
reg Z_reg;
always @(posedge clk)begin
    if(enable)begin
        count <= count + 1'b1;
    end
    else begin
        count <= count;
    end
end

always @(posedge clk)begin
    if(enable)begin
        LUT <= {LUT[6:0],S};
    end
    else begin
        LUT <= LUT;
    end
end

always @(*)begin
    case (opt)
        3'b000:Z_reg <= LUT[0]; 
        3'b001:Z_reg <= LUT[1]; 
        3'b010:Z_reg <= LUT[2]; 
        3'b011:Z_reg <= LUT[3]; 
        3'b100:Z_reg <= LUT[4]; 
        3'b101:Z_reg <= LUT[5]; 
        3'b110:Z_reg <= LUT[6]; 
        3'b111:Z_reg <= LUT[7]; 
        default:Z_reg <= Z_reg;
    endcase
end

assign opt = {A,B,C};
assign Z = Z_reg;
endmodule