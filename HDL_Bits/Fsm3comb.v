module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;
    reg[1:0] next_state_reg;
    reg out_reg;
    // State transition logic: next_state = f(state, in)
    always @(*)begin
        next_state_reg = A;
        case (state)
            A:begin
                if(in)begin
                    next_state_reg = B;
                end
                else begin
                    next_state_reg = A;
                end
            end

            B:begin
                if(in)begin
                    next_state_reg = B;
                end
                else begin
                    next_state_reg = C;
                end
            end

            C:begin
                if(in)begin
                    next_state_reg = D;
                end
                else begin
                    next_state_reg = A;
                end
            end

            D:begin
                if(in)begin
                    next_state_reg = B;
                end
                else begin
                    next_state_reg = C;
                end
            end

            default:next_state_reg = next_state_reg;
        endcase
    end
    // Output logic:  out = f(state) for a Moore state machine

    always @(*)begin
        case (state)
            A:out_reg = 1'b0;
            B:out_reg = 1'b0;
            C:out_reg = 1'b0;
            D:out_reg = 1'b1;
            default:out_reg = 1'b0;
        endcase
    end

    assign out = out_reg;
    assign next_state = next_state_reg;

endmodule