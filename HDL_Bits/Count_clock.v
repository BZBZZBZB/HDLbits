module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    reg pm_reg;
    count_12 u_count_12(
        .clk(clk),
        .reset(reset),
        .en(ena && mm == 8'h59 && ss == 8'h59),
        .dec_data(hh)
    );

    count_60 u_count_60_mm(
        .clk(clk),
        .reset(reset),
        .en(ena && ss == 8'h59),
        .dec_data(mm)
    );

    count_60 u_count_60_ss(
        .clk(clk),
        .reset(reset),
        .en(ena),
        .dec_data(ss)
    );

    always @(posedge clk)begin
        if(reset)begin
            pm_reg <= 0;
        end
        else if(ena && hh == 8'h11 && mm == 8'h59 && ss == 8'h59) begin
            pm_reg <= ~pm_reg;
        end
    end

    assign pm = pm_reg;

endmodule

module count_12(
    input clk,
    input reset,
    input en,
    output [7:0]dec_data
);
reg [7:0] dec_data_reg;

always @(posedge clk)begin
    if(reset)begin
        dec_data_reg <= 8'h12;
    end
    else if(en) begin
        if(dec_data_reg == 8'h12)begin
            dec_data_reg <= 8'h1;
        end
        else if(dec_data_reg[3:0] == 4'h9) begin
            dec_data_reg[3:0] <= 4'h0;
            dec_data_reg[7:4] <= dec_data_reg[7:4] + 1'h1;
        end
        else begin
            dec_data_reg <= dec_data_reg + 1;
        end
    end
    else begin
        dec_data_reg <= dec_data_reg;
    end
end
assign dec_data = dec_data_reg;
endmodule

module count_60(
    input clk,
    input reset,
    input en,
    output [7:0]dec_data
);
reg [7:0] dec_data_reg;

always @(posedge clk)begin
    if(reset)begin
        dec_data_reg <= 8'h0;
    end
    else if(en) begin
        if(dec_data_reg == 8'h59)begin
            dec_data_reg <= 8'h0;
        end
        else if(dec_data_reg[3:0] == 4'h9) begin
            dec_data_reg[3:0] <= 4'h0;
            dec_data_reg[7:4] <= dec_data_reg[7:4] + 1'h1;
        end
        else begin
            dec_data_reg <= dec_data_reg + 1;
        end
    end
    else begin
        dec_data_reg <= dec_data_reg;
    end
end
assign dec_data = dec_data_reg;
endmodule

