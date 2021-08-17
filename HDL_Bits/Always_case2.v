module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*)begin
        //这里为什么要写case(1)而不是case(in)
        //因为case()中的是控制表达式，控制什么时候进入case语句，本题不论什么情况下都应该进入case语句，所以是case(1)
        //verilog中似乎并不是每一个数都有布尔值？？？，有可能是hdlbits编译器的问题。
        case (1)
            in[0]==1:pos = 0;
            in[1]==1:pos = 1;
            in[2]==1:pos = 2;
            in[3]==1:pos = 3;
            default :
                pos = 0;
        endcase
    end
    
endmodule