module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 


reg walk_left_reg;
    reg walk_right_reg;
    reg aaah_reg;
    reg digging_reg;

    reg [6:0] cstate;
    reg [6:0] nstate;
    
    reg [4:0] count;

    

    parameter s1 = 7'b0000001;//正常往左走
    parameter s2 = 7'b0000010;//正常往右走
    parameter s3 = 7'b0000100;//掉落后往左走
    parameter s4 = 7'b0001000;//掉落后往右走
    parameter s5 = 7'b0010000;//左边走开始挖路
    parameter s6 = 7'b0100000;//右边走开始挖路
    parameter s7 = 7'b1000000;//摔死
    always @(posedge clk or posedge areset)begin
        if(areset)begin
            cstate <= s1;
        end
        else begin
            cstate <= nstate;
        end
    end

    always @(posedge clk or posedge areset)begin
        if(areset)begin
            count <= 5'b0;
        end
        else if(~ground && count < 5'd20) begin
           count <= count + 1'b1;
        end
        else if (~ground && count >= 5'd20) begin
            count <= 5'd21;
        end
        else begin
            count <= 'b0;
        end
    end

    always @(*)begin
        nstate = s1;
        case (cstate)
            s1:begin
                if(ground)begin
                    if(~aaah && dig)begin
                        nstate = s5;
                    end
                    else if(bump_left) begin
                        nstate = s2;
                    end
                    else begin
                        nstate = s1;
                    end
                end
                else begin
                    nstate = s3;
                end
                walk_left_reg = 1'b1;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b0;
                digging_reg = 1'b0;
            end

            s2:begin
                if(ground)begin
                    if(~aaah && dig)begin
                        nstate = s6;
                    end
                    else if(bump_right) begin
                        nstate = s1;
                    end
                    else begin
                        nstate = s2;
                    end
                end
                else begin
                    nstate = s4;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b1;
                aaah_reg = 1'b0;
                digging_reg = 1'b0;
            end

            s3:begin
                if(ground && count <= 5'd20)begin
                    nstate = s1;
                end
                else if(ground && count > 5'd20) begin
                    nstate = s7;
                end
                else begin
                    nstate = s3;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b1;
                digging_reg = 1'b0;
            end

            s4:begin
                if(ground && count <= 5'd20)begin
                    nstate = s2;
                end
                else if(ground && count > 5'd20)begin
                    nstate = s7;
                end
                else begin
                    nstate = s4;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b1;
                digging_reg = 1'b0;
            end

            s5:begin
                if(ground)begin
                    nstate = s5;
                end
                else begin
                    nstate = s3;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b0;
                digging_reg = 1'b1;
            end

            s6:begin
                if(ground)begin
                    nstate = s6;
                end
                else begin
                    nstate = s4;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b0;
                digging_reg = 1'b1;
            end

            s7:begin
                nstate = s7;
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b0;
                digging_reg = 1'b0;
            end
            
            default:begin
                nstate = s1;
            end
        endcase
    end

    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;
    assign digging = digging_reg;
    assign aaah = aaah_reg;
endmodule