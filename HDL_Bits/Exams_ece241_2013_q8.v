module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
reg [3:0] nstate;
reg [3:0] cstate;


parameter IDLE = 4'b0001;
parameter s1 = 4'b0010;
parameter s2 = 4'b0100;
parameter s3 = 4'b1000;

always @(posedge clk or negedge aresetn)begin
    if(~aresetn)begin
        cstate <= IDLE;
    end
    else begin
        cstate <= nstate;
    end
end

always @(*)begin
    nstate = IDLE;
    case (cstate)
        IDLE:nstate = x ? s1 : IDLE;
        s1: nstate = x ? s1 : s2;
        s2: nstate = x ? s3 : IDLE;
        s3: nstate = x ? s1 : s2;
        default: nstate = IDLE;
    endcase
end


assign z = nstate == s3 ? 1'b1 : 1'b0;
endmodule
