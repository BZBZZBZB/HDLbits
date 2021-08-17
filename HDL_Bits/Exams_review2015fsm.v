module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
reg [3:0] nstate;
reg [3:0] cstate;

parameter s1 = 4'b0001;
parameter s2 = 4'b0010;
parameter s3 = 4'b0011;
parameter s4 = 4'b0100;
parameter s5 = 4'b0101;
parameter s6 = 4'b0110;
parameter s7 = 4'b0111;
parameter s8 = 4'b1000;
parameter s9 = 4'b1001;
parameter s10 = 4'b1010;
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
        s1:nstate = data ? s2 : s1;
        s2:nstate = data ? s3 : s1;
        s3:nstate = data ? s3 : s4;
        s4:nstate = data ? s5 : s1;
        s5:nstate = s6;
        s6:nstate = s7;
        s7:nstate = s8;
        s8:nstate = s9;
        s9:nstate = done_counting ? s10 : s9;
        s10:nstate = ack ? s1 : s10;
        default:nstate = s1;
    endcase
end
assign shift_ena = cstate == s5 || cstate == s6 || cstate == s7 || cstate == s8;
assign counting = cstate == s9;
assign done = cstate == s10;
endmodule