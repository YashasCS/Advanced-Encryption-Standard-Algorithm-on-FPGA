`timescale 1ns / 1ps
/////////////////////////////
//   SubBytes GF(2^2^2^2)  //
/////////////////////////////
module AES_Comp_SubBytesComp (x, y);
  input  [31:0] x;
  output [31:0] y;

  AES_Comp_SboxComp Sbox3(x[31:24], y[31:24]);
  AES_Comp_SboxComp Sbox2(x[23:16], y[23:16]);
  AES_Comp_SboxComp Sbox1(x[15: 8], y[15: 8]);
  AES_Comp_SboxComp Sbox0(x[ 7: 0], y[ 7: 0]);
endmodule

