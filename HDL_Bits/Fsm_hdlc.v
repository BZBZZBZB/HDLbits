module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

reg [5:0] nstate;
reg [5:0] cstate;

reg [3:0] cnt;
reg disc_reg;
reg flag_reg;
reg err_reg;



parameter IDLE = 6'b000001;
parameter START = 6'b000010;
parameter DATA = 6'b000100;
parameter DISC = 6'b001000;
parameter FLAG = 6'b010000;
parameter ERR = 6'b100000;

always @(posedge clk)begin
    if(reset)begin
        cstate <= START;
    end
    else begin
        cstate <= nstate;
    end
end

always @(*)begin
    if(reset)begin
        nstate = DATA;
    end
    else begin
    case (cstate)
        IDLE:nstate = in ? IDLE : START;
        START:nstate = in ? DATA : IDLE;
        DATA:begin
            if(cnt == 4'd5 && ~in)begin
                nstate = DISC;
            end
            else if(cnt == 4'd6 && ~in)begin
                nstate = FLAG;
            end
            else if(cnt == 4'd7 && ~in)begin
                nstate = ERR;
            end
            else begin
                nstate = nstate;
            end
        end
        DISC:nstate = in ? DATA : IDLE;
        FLAG:nstate = in ? DATA : IDLE;
        ERR: nstate = in ? ERR : IDLE;
        default:nstate = IDLE;
    endcase
    end
end

always @(posedge clk)begin
    if(reset)begin
        cnt <= 4'b0;
    end
    else if(nstate == DATA) begin
        cnt <= cnt + 1'b1;
    end
    else begin
        cnt <= 4'b0;
    end
end

always @(posedge clk)begin
    if(reset)begin
       disc_reg <= 1'b0;
       flag_reg <= 1'b0;
       err_reg <= 1'b0; 
    end
    else if(nstate == DISC) begin
        disc_reg <= 1'b1;
    end
    else if(nstate == FLAG)begin
        flag_reg <= 1'b1;
    end
    else if(nstate == ERR) begin
        err_reg <= 1'b1;
    end
    else begin
        disc_reg <= disc_reg;
        flag_reg <= flag_reg;
        err_reg <= err_reg;
    end
end

assign disc = disc_reg;
assign flag = flag_reg;
assign err = err_reg;

endmodule