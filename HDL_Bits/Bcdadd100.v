module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    reg cout_reg[100:0];

    always @(*)begin
        cout_reg[0] = cin;
    end

    
     generate
     genvar i;
         for(i = 0;i <100;i = i + 1)begin:BCD_ADD
         //verilog中的数组索引只能采用这样的方式，意思是从(i * 4 + 3)位置开始，向下取四个数据
         //这里就类似于有一个基地址、数据长度，然后取数据。更加符合底层操作习惯。
         //注意减号和冒号之间不可以有空格，不然会报错
             bcd_fadd u_bcd_fadd(
                 .a(a[(i * 4 + 3)-:4]),
                 .b(b[(i * 4 + 3)-:4]),
                 .cin(cout_reg[i]),
                 .cout(cout_reg[i + 1]),
                 .sum(sum[(i * 4 + 3)-:4])
             );
        end
    endgenerate
    assign cout = cout_reg[100];
    
endmodule

// module bcd_fadd {
//     input [3:0] a,
//     input [3:0] b,
//     input     cin,
//     output   cout,
//     output [3:0] sum );
