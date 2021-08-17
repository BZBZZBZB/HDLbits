module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

reg [2:0] cstate;
reg [2:0] nstate;

reg shift_ena_reg;

parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;
parameter s5 = 3'b101;

always @(posedge clk)begin
    if(reset)begin
        cstate <= s1;
    end
    else begin
        cstate <= nstate;
    end
end

always @(*)begin
    nstate = s1;
    case (cstate)
        s1:nstate = s2;
        s2:nstate = s3;
        s3:nstate = s4;
        s4:nstate = s5;
        s5:nstate = s5;
        default:nstate = s1;
    endcase
end

always @(*)begin
    if(cstate == s2 || cstate == s3 || cstate == s4 || cstate == s1)begin
        shift_ena_reg = 1'b1;
    end
    else begin
        shift_ena_reg <= 1'b0;
    end
end

assign shift_ena = shift_ena_reg;
endmodule