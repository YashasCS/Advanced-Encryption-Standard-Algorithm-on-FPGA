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
module aes_pipelined_tb();

reg clk, rstn, data_valid_in, cipherkey_valid_in;
reg  [127:0] key, data_in_aes;
wire [127:0] data_out;
wire valid_out;

aes_pipelined aes_pipelined_inst (
   .clk(clk)
  ,.reset(rstn)
  ,.data_valid_in(data_valid_in)
  ,.cipherkey_valid_in(cipherkey_valid_in)
  ,.cipher_key(key)
  ,.plain_text(data_in_aes)
  ,.valid_out(valid_out)
  ,.cipher_text(data_out)
);

  initial begin
    clk                 = 1'b0;
    rstn                = 1'b0;
    data_valid_in       = 1'b0;
    cipherkey_valid_in  = 1'b0;
    key                 = 128'h0;
    data_in_aes         = 128'h0;
    #20
    rstn                = 1'b1;
    key                 = 128'h000102030405060708090a0b0c0d0e0f;
    data_in_aes         = 128'h213a22ae33162fcdd51a643b7dd45768;
    data_valid_in       = 1'b1;
    cipherkey_valid_in  = 1'b1;
    #30;
    data_valid_in       = 1'b0;
    cipherkey_valid_in  = 1'b0;
    #1500;
    key                 = 128'h000102030405060708090a0b0c0d0e0f;
    data_in_aes         = 128'h990e996ae81c684b45d6da33779dcd52;
    data_valid_in       = 1'b1;
    cipherkey_valid_in  = 1'b1;
    #2000;
    $finish();
  end

always #5 clk = ~clk;


always @ (posedge valid_out) begin 
  $display("Key = %x, Din = %x, Dout = %x", key, data_in_aes, data_out);
end

endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Key = 000102030405060708090a0b0c0d0e0f, Din = 213a22ae33162fcdd51a643b7dd45768, Dout = 94e6b5d960b5db1831f7f8f6e4d3e48f
//xsim: Time (s): cpu = 00:00:13 ; elapsed = 00:00:06 . Memory (MB): peak = 6867.289 ; gain = 40.242 ; free physical = 75355 ; free virtual = 337756
//INFO: [USF-XSim-96] XSim completed. Design snapshot 'aes_pipelined_tb_behav' loaded.
//  INFO: [USF-XSim-97] XSim simulation ran for 1000ns
//  launch_simulation: Time (s): cpu = 00:00:27 ; elapsed = 00:00:15 . Memory (MB): peak = 6867.289 ; gain = 40.242 ; free physical = 75340 ; free virtual = 337742
//run all
//Key = 000102030405060708090a0b0c0d0e0f, Din = 990e996ae81c684b45d6da33779dcd52, Dout = e356639e3de072ff1981bacb030c1aa2
//$finish called at time : 3550 ns : File "/home/grads/g/gjn/ECEN489_FPGA_LAB1/AES_LAB/PIPELINED/aes_lab/aes_lab.srcs/sources_1/imports/new/aes_pipelined_tb.v" Line 63
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

