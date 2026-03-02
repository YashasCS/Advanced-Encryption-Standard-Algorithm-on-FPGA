`timescale 1ns / 1ps
/////////////////////////////
//   GF(2^2^2^2) inverter  //
/////////////////////////////
module AES_Comp_GFinvComp(x, y);
  input  [7:0] x;
  output [7:0] y;

  wire [8:0] da, db, dx, dy, va, tp, tn;
  wire [3:0] u, v;
  wire [4:0] mx;
  wire [5:0] my;

  assign da ={x[3], x[2]^x[3], x[2], x[1]^x[3], x[0]^x[1]^x[2]^x[3], x[0]^x[2], x[1], x[0]^x[1], x[0]};
  assign db ={x[7], x[6]^x[7], x[6], x[5]^x[7], x[4]^x[5]^x[6]^x[7], x[4]^x[6], x[5], x[4]^x[5], x[4]};
  assign va ={v[3], v[2]^v[3], v[2], v[1]^v[3], v[0]^v[1]^v[2]^v[3], v[0]^v[2], v[1], v[0]^v[1], v[0]};
  assign dx = da ^ db;
  assign dy = da & dx;
  assign tp = va & dx;
  assign tn = va & db;

  assign u = {dy[0] ^ dy[1] ^ dy[3] ^ dy[4] ^ x[4] ^ x[5] ^ x[6],
              dy[0] ^ dy[2] ^ dy[3] ^ dy[5] ^ x[4] ^ x[7],
              dy[0] ^ dy[1] ^ dy[7] ^ dy[8] ^ x[7],
              dy[0] ^ dy[2] ^ dy[6] ^ dy[7] ^ x[6] ^ x[7]};

  assign y = {tn[0] ^ tn[1] ^ tn[3] ^ tn[4], tn[0] ^ tn[2] ^ tn[3] ^ tn[5],
              tn[0] ^ tn[1] ^ tn[7] ^ tn[8], tn[0] ^ tn[2] ^ tn[6] ^ tn[7],
              tp[0] ^ tp[1] ^ tp[3] ^ tp[4], tp[0] ^ tp[2] ^ tp[3] ^ tp[5],
              tp[0] ^ tp[1] ^ tp[7] ^ tp[8], tp[0] ^ tp[2] ^ tp[6] ^ tp[7]};

  ////////////////////////
  // GF(2^2^2) Inverter //
  ////////////////////////
    assign mx = {mx[0] ^ mx[1] ^ u[2],
                 mx[0] ^ mx[2] ^ u[3],
                 u[1] & (u[1] ^ u[3]),
                 (u[0] ^ u[1]) & (u[0] ^ u[1]  ^ u[2] ^ u[3]),
                 u[0] & (u[0] ^ u[2])};

    assign my = {~(mx[4] & u[3]),
                 ~(mx[3] & (u[2] ^ u[3])),
                 ~((mx[3] ^ mx[4]) & u[2]),
                 ~(mx[4] & (u[1] ^ u[3])),
                 ~(mx[3] & (u[0] ^ u[1]  ^ u[2] ^ u[3])),
                 ~((mx[3] ^ mx[4]) & (u[0] ^ u[2]))};

    assign v = {my[3]^my[4], my[3]^my[5], my[0]^my[1], my[0]^my[2]};
endmodule

