module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
reg [3:0] nstate;
reg [3:0] cstate;

reg [9:0] cnt;

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
reg [3:0] count_reg;


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
        s9:begin
            if(cnt == 10'b0 && count == 1'b0)begin
                nstate = s10;
            end
            else begin
                nstate = s9;
            end
        end
        s10:nstate = ack ? s1 : s10;
        default:nstate = s1;
    endcase
end

always @(posedge clk)begin
    if(reset)begin
        cnt <= 10'd999;
    end
    else if(cnt == 10'd0)begin
        cnt <= 10'd999;
    end
    else if(cstate == s9) begin
        cnt <= cnt - 1'b1;
    end
    else begin
        cnt <= 10'd999;
    end
end

always @(posedge clk)begin
    if(reset)begin
        count_reg <= 4'b0;
    end
    else if(cstate == s5) begin
        count_reg[3] <= data;
    end
    else if(cstate == s6) begin
        count_reg[2] <= data;
    end
    else if (cstate == s7) begin
        count_reg[1] <= data;
    end
    else if (cstate == s8) begin
        count_reg[0] <= data;
    end
    else if(cnt == 10'b0)begin
        count_reg <= count_reg - 1'b1;
    end
    else begin
        count_reg <= count_reg;
    end
end

assign count = count_reg;
assign counting = cstate == s9;
assign done = cstate == s10;

endmodule