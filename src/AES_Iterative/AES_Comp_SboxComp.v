`timescale 1ns / 1ps
/////////////////////////////
//     Sbox GF(2^2^2^2)    //
/////////////////////////////
module AES_Comp_SboxComp(x, y);
  input  [7:0] x;
  output [7:0] y;

  wire [7:0] a, b;

  assign a = {x[5] ^ x[7],
              x[1] ^ x[2] ^ x[3] ^ x[4] ^ x[6] ^ x[7],
              x[2] ^ x[3] ^ x[5] ^ x[7],
              x[1] ^ x[2] ^ x[3] ^ x[5] ^ x[7],
              x[1] ^ x[2] ^ x[6] ^ x[7],
              x[1] ^ x[2] ^ x[3] ^ x[4] ^ x[7],
              x[1] ^ x[4] ^ x[6],
              x[0] ^ x[1] ^ x[6]};

  AES_Comp_GFinvComp AES_Comp_GFinvComp(a, b);

  assign y = { b[2] ^ b[3] ^ b[7],
              ~b[4] ^ b[5] ^ b[6] ^ b[7],
              ~b[2] ^ b[7],
               b[0] ^ b[1] ^ b[4] ^ b[7],
               b[0] ^ b[1] ^ b[2],
               b[0] ^ b[2] ^ b[3] ^ b[4] ^ b[5] ^ b[6],
              ~b[0] ^ b[7],
              ~b[0] ^ b[1] ^ b[2] ^ b[6] ^ b[7]};
endmodule


