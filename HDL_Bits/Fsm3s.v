module top_module(
    input clk,
    input in,
    input reset,
    output out); //
    //如果是同步复位，三段式状态机和两段式状态机输出相同，但是异步复位会有偏差
    reg [3 : 0] nstate;
    reg [3 : 0] cstate;
    reg out_reg;
    parameter A = 4'd1;
    parameter B = 4'd2;
    parameter C = 4'd4;
    parameter D = 4'd8;
    
    always @(posedge clk)begin
        if(reset)begin
        cstate <= A;
    end
        else begin
        cstate <= nstate;
    end
    end

always @(*)begin
        nstate = A;
        case(cstate)
        A:begin
            if(in)
                nstate = B;
            else 
                nstate = A;
        end
        B:begin
            if(in)
                nstate = B;
            else
                nstate = C;
        end
        C:begin
            if(in)
                nstate = D;
            else
                nstate = A;
        end
        D:begin
            if(in)
                nstate = B;
            else
                nstate = C;
        end
        default:
            nstate = A;
      endcase
    end
    always @(posedge clk )begin
        if(reset)begin
            out_reg <= 0;
        end
        case(nstate)
        A:begin
            out_reg <= 1'b0;
        end
        B:begin
            out_reg <= 1'b0;
        end
        C:begin
            out_reg <= 1'b0;
        end
        D:begin
            out_reg <= 1'b1;
        end
        default:begin
            out_reg <= 1'b0;
        end
      endcase
    end
    assign out = out_reg;
    // State transition logic

    // State flip-flops with synchronous reset

    // Output logic

endmodule