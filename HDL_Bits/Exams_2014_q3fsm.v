module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
reg [4:0] cstate;
reg [4:0] nstate;

reg [1:0] cnt;

parameter A  = 5'b00001;
parameter B  = 5'b00010;
parameter s1 = 5'b00100;
parameter s2 = 5'b01000;
parameter s3 = 5'b10000;

reg z_reg;
always @(posedge clk)begin
    if(reset)begin
        cstate <= A;
    end
    else begin
        cstate <= nstate;
    end
end

always @(posedge clk)begin
    if(reset)begin
        cnt <= 3'b0;
    end
    else if(nstate != A && cnt < 2'd3) begin 
        cnt <= cnt + 1'b1;
    end
    else if(cnt == 2'd3)begin
        cnt <= 2'd1;
    end
    else begin
        cnt <= 3'b0;
    end
end

always @(*)begin
    nstate = A;
    case (cstate)
        A:nstate = s ? B : A;
        B:nstate = w ? s1 : B;
        s1: begin
            if(cnt == 2'd1)begin
                if(w)begin
                    nstate = s1;
                end
                else begin
                    nstate = B;
                end
            end
            else begin
                if(w)begin
                    nstate = s2;
                end
                else begin
                    nstate = s1;
                end
            end
        end
        s2: begin
            if(cnt == 2'd1)begin
                if(w)begin
                    nstate = s1;
                end
                else begin
                    nstate = B;
                end
            end
            else begin
                if(w)begin
                    nstate = s3;
                end
                else begin
                    nstate = s2;
                end
            end
        end
        s3: nstate = w ? s1 : B;
        default:nstate = A;
    endcase
end
always @(posedge clk)begin
    if(reset)begin
        z_reg <= 1'b0;
    end
    else if(nstate == s2 && cnt == 2'd3) begin
        z_reg <= 1'b1;
    end
    else begin
        z_reg <= 1'b0;
    end
end

assign z = z_reg;
endmodule
