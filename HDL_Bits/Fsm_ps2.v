module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    reg [3:0] cstate;
    reg [3:0] nstate;
    reg done_reg;
    parameter s0 = 4'b0001;
    parameter s1 = 4'b0010;
    parameter s2 = 4'b0100;
    parameter s3 = 4'b1000;
    // State transition logic (combinational)

    // State flip-flops (sequential)
 
    // Output logic
    always @(posedge clk)begin
        if(reset)begin
            cstate <= s0;
        end
        else begin
            cstate <= nstate;
        end
    end


    always @(*)begin
        nstate = s0;
        case (cstate)
            s0:begin
                if(in[3])begin
                    nstate = s1;
                end
                else begin
                    nstate = s0;
                end
                done_reg = 1'b0;
            end

            s1:begin
                nstate = s2;
                done_reg = 1'b0;
            end

            s2:begin
              nstate = s3;
              done_reg = 1'b0;  
            end

            s3:begin
                if(in[3])begin
                    nstate = s1;
                end
                else begin
                    nstate = s0;
                end
                done_reg = 1'b1;
            end
            default:begin
                nstate = s0;
                done_reg = 1'b0;
            end
        endcase
    end
    assign done = done_reg;
endmodule