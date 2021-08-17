module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    reg [23:0] out_bytes_reg;
    reg done_reg;

    reg [7:0] in_delay1;
    reg [7:0] in_delay2;
    reg [7:0] in_delay3;

    reg [3:0] cstate;
    reg [3:0] nstate;

    parameter s0 = 4'b0001;
    parameter s1 = 4'b0010;
    parameter s2 = 4'b0100;
    parameter s3 = 4'b1000;

    always @(posedge clk )begin
        if(reset)begin
            in_delay1 <= 'b0;
            in_delay2 <= 'b0;
            in_delay3 <= 'b0;
        end
        else begin
            case (cstate)
                s0:in_delay1 <= in;
                s1:in_delay2 <= in;
                s2:in_delay3 <= in;
                s3:begin
                    if(in[3])begin
                        in_delay1 <= in;
                    end
                    else begin
                        in_delay1 <= in_delay1;
                    end
                end
                default:begin
                    in_delay1 <= 'b0;
                    in_delay2 <= 'b0;
                    in_delay3 <= 'b0;
                end
            endcase
        end
    end

    always @(posedge clk )begin
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
                done_reg = 'b0;
                out_bytes_reg = 'b0;
            end

            s1:begin
                nstate = s2;
                done_reg = 'b0;
                out_bytes_reg = 'b0;
            end

            s2:begin
                nstate = s3;
                done_reg = 'b0;
                out_bytes_reg = 'b0;
            end

            s3:begin
                if(in[3])begin
                    nstate = s1;
                end
                else begin
                    nstate = s0;
                end
                done_reg = 'b1;
                out_bytes_reg = {in_delay1,in_delay2,in_delay3};
            end
            default:begin
                nstate = s0;
            end
        endcase
    end

    assign out_bytes = out_bytes_reg;
    assign done = done_reg;

endmodule