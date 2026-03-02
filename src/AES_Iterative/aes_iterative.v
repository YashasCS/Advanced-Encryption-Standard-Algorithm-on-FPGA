/*-------------------------------------------------------------------------
 AES Encryption Macro (ASIC version)
                                   
 File name   : aes_iterative.v
 Version     : Version 1.0
 Created     : 
 Last update : SEP/25/2007
 Desgined by : Akashi Satoh
 
 
 Copyright (C) 2007 AIST and Tohoku Univ.
 
 By using this code, you agree to the following terms and conditions.
 
 This code is copyrighted by AIST and Tohoku University ("us").
 
 Permission is hereby granted to copy, reproduce, redistribute or
 otherwise use this code as long as: there is no monetary profit gained
 specifically from the use or reproduction of this code, it is not sold,
 rented, traded or otherwise marketed, and this copyright notice is
 included prominently in any copy made.
 
 We shall not be liable for any damages, including without limitation
 direct, indirect, incidental, special or consequential damages arising
 from the use of this code.
 
 When you publish any results arising from the use of this code, we will
 appreciate it if you can cite our webpage
 (http://www.aoki.ecei.tohoku.ac.jp/crypto/).
 -------------------------------------------------------------------------*/

`timescale 1ns / 1ps
module aes_iterative (Kin, Din, Dout, RSTn, EN, CLK, BSY);
  input  [127:0] Kin;  // Key input
  input  [127:0] Din;  // Data input
  output [127:0] Dout; // Data output
  input  RSTn;         // Reset (Low active)
  input  EN;           // AES circuit enable
  input  CLK;          // System clock
  output BSY;          // Busy signal

  wire EN_E, BSY_E;
  wire [127:0] Dout_E;

  assign EN_E = EN;
  assign BSY  = BSY_E;
  assign Dout = Dout_E;

  AES_Comp_ENC AES_Comp_ENC(Kin, Din, Dout_E, RSTn, EN_E, CLK, BSY_E);

endmodule
