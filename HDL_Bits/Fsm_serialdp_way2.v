module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata

    // New: Add parity checking.
reg [4:0] nstate;
reg [4:0] cstate;

reg done_reg;
reg [8:0] out_byte_reg;

reg [3:0] count;

wire in_parity;
wire odd;
wire en;


parameter s1 = 5'b00001;//初始状态
parameter s2 = 5'b00010;//开始状态
parameter s3 = 5'b00100;//数据状态
parameter s4 = 5'b01000;//正常停止状态
parameter s5 = 5'b10000;//错误停止状态

always @(posedge clk)begin
    if(reset)begin
        cstate <= s1;
    end
    else begin
        cstate <= nstate;
    end
end


always @(posedge clk)begin
    if(reset)begin
        count <= 3'b0;
        out_byte_reg <= 8'b0;
    end
    else if(nstate == s3) begin
        count <= count + 1'b1;
        out_byte_reg[count] <= in;
    end
    else begin
        count <= 3'b0;
    end
end

always @(*)begin
    nstate = s1;
    case (cstate)
        s1:begin
            if(~in)begin
                nstate = s2;
            end
            else begin
                nstate = s1;
            end
        end

        s2:begin
            nstate = s3;
        end

        s3:begin
            nstate = count == 4'd9 ? ((in && odd) ? s4 : s5) : s3;
        end

        s4:begin
            if(~in)begin
                nstate = s2;
            end
            else begin
                nstate = s1;
            end
        end
        s5:begin
            if(in)begin
                nstate = s1;
            end
            else begin
                nstate = s5;
            end
        end
    endcase
end

always @(posedge clk)begin
    if(reset)begin
        done_reg <= 1'b0;
    end
    else if(nstate == s4) begin
        done_reg <= 1'b1;
    end
    else begin
        done_reg <= 1'b0;
    end
end

parity u_parity(
    .clk(clk),
    .reset(en),
    .in(in),
    .odd(odd)
);

// assign in_parity = (nstate == s3 || (nstate == s6)) ? in : 1'b0;
assign en = reset || nstate == s1 || nstate == s2;
assign done = done_reg;
assign out_byte = out_byte_reg[7:0];
endmodule
// module parity (
//     input clk,
//     input reset,
//     input in,
//     output reg odd);

//     always @(posedge clk)
//         if (reset) odd <= 0;
//         else if (in) odd <= ~odd;

// endmodule