module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

reg [9:0] next_state_reg;
reg out1_reg;
reg out2_reg;

parameter s0 = 10'b00_0000_0001;
parameter s1 = 10'b00_0000_0010;
parameter s2 = 10'b00_0000_0100;
parameter s3 = 10'b00_0000_1000;
parameter s4 = 10'b00_0001_0000;
parameter s5 = 10'b00_0010_0000;
parameter s6 = 10'b00_0100_0000;
parameter s7 = 10'b00_1000_0000;
parameter s8 = 10'b01_0000_0000;
parameter s9 = 10'b10_0000_0000;

always @(*)begin
    next_state_reg = 'b0;
    case (state)
        s0:begin
            if(in)begin
                next_state_reg = s1;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end
        s1:begin
            if(in)begin
                next_state_reg = s2;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end

        s2:begin
            if(in)begin
                next_state_reg = s3;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end

        s3:begin
            if(in)begin
                next_state_reg = s4;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end

        s4:begin
            if(in)begin
                next_state_reg = s5;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end

        s5:begin
            if(in)begin
                next_state_reg = s6;
            end
            else begin
                next_state_reg = s8;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end

        s6:begin
            if(in)begin
                next_state_reg = s7;
            end
            else begin
                next_state_reg = s9;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end

        s7:begin
            if(in)begin
                next_state_reg = s7;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b0;
            out2_reg = 1'b1;
        end

        s8:begin
            if(in)begin
                next_state_reg = s1;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b1;
            out2_reg = 1'b0;
        end

        s9:begin
            if(in)begin
                next_state_reg = s1;
            end
            else begin
                next_state_reg = s0;
            end
            out1_reg = 1'b1;
            out2_reg = 1'b1;
        end

        default:begin
            out1_reg = 1'b0;
            out2_reg = 1'b0;
        end
    endcase
end

assign out1 = out1_reg;
assign out2 = out2_reg;
assign next_state = next_state_reg;
endmodule