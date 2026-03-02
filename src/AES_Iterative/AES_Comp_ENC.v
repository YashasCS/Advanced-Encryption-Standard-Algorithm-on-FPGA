/////////////////////////////
//   AES for encryption    //
/////////////////////////////
`timescale 1ns / 1ps
`define    IDLE          2'b00
`define    ADD_ROUND     2'b01
`define    ROUNDS_TEN    2'b10

module AES_Comp_ENC(Kin, Din, Dout, RSTn, EN, CLK, BSY);
  input  [127:0] Kin;  // Key input
  input  [127:0] Din;  // Data input
  output [127:0] Dout; // Data output
  input  RSTn;         // Reset (Low active)
  input  EN;           // AES circuit enable
  input  CLK;          // System clock
  output BSY;          // Busy signal
  (* dont_touch = "true" *) reg [127:0] Drg;
  reg  [127:0] Krg;    // Key register
  reg  [127:0] KrgX;   // Temporary key Register
  reg  [9:0]   Rrg;    // Round counter
  reg  Kvldrg, Dvldrg, BSYrg, enable_d, start, enable_dd;
  wire EN_pulse;
  wire [127:0] Dnext, Knext;
  reg [1:0] state;

  AES_Comp_EncCore EC (Drg, KrgX, Rrg, Dnext, Knext);

  assign Dout = Drg;
  assign BSY  = BSYrg;

  always @ (posedge CLK or negedge RSTn) begin
    if(RSTn == 1'b0) begin
      enable_d  <= 0;
      enable_dd <= 0;
    end
    else begin
      enable_d  <= EN;
      enable_dd <= enable_d;
    end
  end

  assign EN_pulse = EN && ~(enable_dd);

  always @ (posedge CLK or negedge RSTn) begin
    if(RSTn == 1'b0) begin
      Krg    <= 128'h0000000000000000;
      KrgX   <= 128'h0000000000000000;
      Rrg    <= 10'b0000000001;
      BSYrg  <= 0;
      Dvldrg <= 0;
      Drg    <= 0;
      state  <= `IDLE;
    end 
    else begin
      case (state) 
        `IDLE: begin
          if(EN_pulse) begin
            Krg    <= Kin;
            KrgX   <= Kin;
            Rrg    <= 10'b0000000001;
            Dvldrg <= 0;
            Drg    <= 0;
            state  <= `ADD_ROUND;
          end
          else begin
            state  <= `IDLE;
          end
        end 
        `ADD_ROUND: begin
          Rrg    <= {Rrg[8:0], Rrg[9]};
          KrgX   <= Knext;
          Drg    <= Din ^ Krg;
          BSYrg  <= 1;
          Dvldrg <= 0;
          state  <= `ROUNDS_TEN;
        end 
        `ROUNDS_TEN: begin
          Drg    <= Dnext;
          if (Rrg[0] == 1) begin
            KrgX   <= Krg;
            Dvldrg <= 1;
            BSYrg  <= 0;
            state  <= `IDLE;
          end
          else begin
            Rrg    <= {Rrg[8:0], Rrg[9]};
            KrgX   <= Knext;
            state  <= `ROUNDS_TEN;
          end
        end 
      endcase
    end
  end
  
endmodule

