module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // State transition logic
    reg [3 : 0] nstate;
    reg [3 : 0] cstate;
    reg out_reg;
    parameter A = 4'd1;
    parameter B = 4'd2;
    parameter C = 4'd4;
    parameter D = 4'd8;
    
    always @(posedge clk or posedge areset)begin
        if(areset)begin
        cstate <= A;
    end
        else begin
        cstate <= nstate;
    end
    end

    always @(*)begin
        nstate = A;
        case (cstate)
        A:begin
            if(in)
                nstate = B;
            else 
                nstate = A;
            out_reg = 1'b0;
        end
        B:begin
            if(in)
                nstate = B;
            else
                nstate = C;
            out_reg = 1'b0;
        end
        C:begin
            if(in)
                nstate = D;
            else
                nstate = A;
            out_reg = 1'b0;
        end
        D:begin
            if(in)
                nstate = B;
            else
                nstate = C;
            out_reg = 1'b1;
        end
        default:begin
            nstate = A;
            out_reg = 1'b0;    
        end      
        endcase
    end
    
    // always @(*)begin
    //     nstate = A;
    //     case(cstate)
    //     A:begin
    //         if(in)
    //             nstate = B;
    //         else 
    //             nstate = A;
    //     end
    //     B:begin
    //         if(in)
    //             nstate = B;
    //         else
    //             nstate = C;
    //     end
    //     C:begin
    //         if(in)
    //             nstate = D;
    //         else
    //             nstate = A;
    //     end
    //     D:begin
    //         if(in)
    //             nstate = B;
    //         else
    //             nstate = C;
    //     end
    //     default:
    //         nstate = A;
    //   endcase
    // end
    // always @(posedge clk or posedge areset)begin
    //     if(areset)begin
    //         out_reg <= 0;
    //     end
    //     case(nstate)
    //     A:begin
    //         out_reg <= 1'b0;
    //     end
    //     B:begin
    //         out_reg <= 1'b0;
    //     end
    //     C:begin
    //         out_reg <= 1'b0;
    //     end
    //     D:begin
    //         out_reg <= 1'b1;
    //     end
    //     default:begin
    //         out_reg <= 1'b0;
    //     end
    //   endcase
    // end

    // State flip-flops with asynchronous reset

    // Output logic
assign out = out_reg;
endmodule