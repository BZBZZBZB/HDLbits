module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
reg [2:0] nstate;
reg [2:0] cstate;




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
        s1:nstate = data ? s2 : s1;
        s2:nstate = data ? s3 : s1;
        s3:nstate = data ? s3 : s4;
        s4:nstate = data ? s5 : s1;
        s5:nstate = s5;
        default:nstate = s1;
    endcase
end

assign start_shifting = cstate == s5;
endmodule
