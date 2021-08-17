module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
reg fr1_reg;
reg fr2_reg;
reg fr3_reg;
reg dfr_reg;
reg [2 : 0] nstate;
reg [2 : 0] cstate;
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b011;
parameter S3 = 3'b111;



always @(posedge clk)begin
    if(reset)begin
        cstate <= s;
    end
    else begin
        cstate <= nstate;
    end
end

always @(*)begin
    nstate = S0;
    case (cstate)
        3'b000:begin
            nstate = S3;
            fr1_reg = 1'b1;
            fr2_reg = 1'b1;
            fr3_reg = 1'b1;
        end
        3'b001:begin
            nstate = S2;
            fr1_reg = 1'b1;
            fr2_reg = 1'b1;
            fr3_reg = 1'b0;
        end
        3'b011:begin
            nstate = S1;
            fr1_reg = 1'b1;
            fr2_reg = 1'b0;
            fr3_reg = 1'b0;
        end
        3'b111:begin
            nstate = S0;
            fr1_reg = 1'b0;
            fr2_reg = 1'b0;
            fr3_reg = 1'b0;
        end
    endcase
end
always @(posedge clk)begin
    if(reset)begin
        dfr_reg <= 'b0;
    end
    else if(nstate > cstate)begin
        dfr_reg <= 1'b1;
    end
    else begin
        dfr_reg <= 1'b0;
    end
end

assign dfr = dfr_reg;
assign fr1 = fr1_reg;
assign fr2 = fr2_reg;
assign fr3 = fr3_reg;

// module top_module (
//     input clk,
//     input reset,
//     input [3:1] s,
//     output fr3,
//     output fr2,
//     output fr1,
//     output dfr
// );  
//     reg [1:0] state , nstate;
//     reg [2:0] outfr;
//     parameter 
//     t1 = 2'b00,
//     t2 = 2'b01,
//     t3 = 2'b10,
//     t4 = 2'b11;
//     assign {fr3,fr2,fr1} = outfr;
//     always@(posedge clk)begin
//      if(reset)
//             state <= t1;
//         else
//             state <= nstate;
//     end
//     always@(*)begin
//         nstate = t1;
//         case(s)
//             3'b000:nstate = t1;
//             3'b001:nstate = t2;
//             3'b011:nstate = t3;
//             3'b111:nstate = t4;
//             default:nstate = t1;
//         endcase
//     end
//     always@(posedge clk)begin
//         if(reset)
//         	outfr <= 3'b111;     
//         else begin
//             case(nstate)
//                 t1:outfr <= 3'b111;
//                 t2:outfr <= 3'b011;
//                 t3:outfr <= 3'b001;
//                 t4:outfr <= 3'b000;
//             endcase
//         end   
//     end
//     always@(posedge clk)begin
//         if(reset)
//         	dfr <= 1;
//         else begin 
//             if(nstate < state)
//                 dfr <= 1;
//             else if(nstate > state)
//                 dfr <= 0;
//             else 
//                 dfr <= dfr;
//         end
//     end
// endmodule

endmodule