module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
reg [1:0] cstate;
reg [1:0] nstate;
reg [3:1] g_reg;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;


always @(posedge clk)begin
    if(~resetn)begin
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
            casez (r)
                3'b000:nstate = A;
                3'b??1:nstate = B;
                3'b?10:nstate = C;
                3'b100:nstate = D;
                default:nstate = A;
            endcase
        end
        B:begin
            case (r[1])
                1'b1:nstate = B;
                1'b0:nstate = A;
                default: nstate = A;
            endcase
        end
        C:begin
            case (r[2])
                1'b1:nstate = C;
                1'b0:nstate = A;
                default:nstate = A;
            endcase
        end
        D:begin
            case (r[3])
                1'b1:nstate = D;
                1'b0:nstate = A;
                default:nstate = A;
            endcase
        end
        default:nstate = A;
    endcase
end

always @(posedge clk)begin
    if(~resetn)begin
        g_reg <= 3'b0;
    end
    else  begin
        case (nstate)
            A:g_reg <= 3'b000;
            B:g_reg <= 3'b001;
            C:g_reg <= 3'b010;
            D:g_reg <= 3'b100;
            default:g_reg <= 3'b000;
        endcase
    end
end
assign g = g_reg;
endmodule