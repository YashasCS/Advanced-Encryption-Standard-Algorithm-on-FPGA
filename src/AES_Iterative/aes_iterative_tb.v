//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2020 06:38:17 PM
// Design Name: 
// Module Name: AES_Comp_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
module aes_iterative_tb();

reg clk, rstn, enable;
reg  [127:0] key, data_in_aes;
wire [127:0] data_out;
wire bsy;

  aes_iterative aes_iterative_inst (
     .Kin(key)
    ,.Din(data_in_aes)
    ,.Dout(data_out)
    ,.RSTn(rstn)
    ,.EN(enable)
    ,.CLK(clk)
    ,.BSY(bsy)
  );

  initial begin
    clk         = 1'b0;
    rstn        = 1'b0;
    enable      = 1'b0;
    key         = 128'h0;
    data_in_aes = 128'h0;
    #20
    rstn        = 1'b1;
    key         = 128'h000102030405060708090a0b0c0d0e0f;
    data_in_aes = 128'h213a22ae33162fcdd51a643b7dd45768;
    enable      = 1'b1;
    #30;
    enable      = 1'b0;
    #150;
    data_in_aes = 128'h990e996ae81c684b45d6da33779dcd52;
    enable      = 1'b1;
    #200;
    $finish();
  end

always #5 clk = ~clk;


always @ (negedge bsy) begin 
  $display("Key = %x, Din = %x, Dout = %x", key, data_in_aes, data_out);
end

endmodule


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The simulation output of the above testbench is given below:
// Time resolution is 1 ps
// Key = 00000000000000000000000000000000, Din = 00000000000000000000000000000000, Dout = 00000000000000000000000000000000
// Key = 000102030405060708090a0b0c0d0e0f, Din = 213a22ae33162fcdd51a643b7dd45768, Dout = 94e6b5d960b5db1831f7f8f6e4d3e48f
// Key = 000102030405060708090a0b0c0d0e0f, Din = 990e996ae81c684b45d6da33779dcd52, Dout = e356639e3de072ff1981bacb030c1aa2
// $finish called at time : 400 ns : File "/home/grads/g/gjn/ECEN489_FPGA_LAB1/aes_lab/aes_lab.srcs/sources_1/imports/new/aes_iterative_tb.v" Line 57
// relaunch_sim: Time (s): cpu = 00:00:04 ; elapsed = 00:00:07 . Memory (MB): peak = 8314.379 ; gain = 7.996 ; free physical = 87138 ; free virtual = 332782
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

