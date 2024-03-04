`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UMG
// Engineer: Alejandro de León
// 
// Create Date: 04.03.2024 00:18:54
// Design Name: sumador 4bits RippleCarry
// Module Name: RippleCarry
// Project Name: Primer parcial
// Target Devices: Basys3 
// Tool Versions: 
// Description: Programa de implementacion de un RippleCarry de 4bits
// 
// Dependencies: 
// 
// Revision:1
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FullAdder(
    input  A, B, Cin,
    output S, Cout
   );
    
assign Sum  = A ^ B ^ Cin;
assign Cout = (A & B)|(Cin & (A^B));
    
endmodule

module RippleCarry(
    input [8:0]sw, //0-3A, 4-7B
    output [4:0]led //S0,S1,S2,S3,Cout
    );
wire[3:0]c; //internal carries
    
FullAdder FA0(sw[0],sw[4],sw[8],led[0],c[0]);
FullAdder FA1(sw[1],sw[5],c[0],led[1],c[1]);
FullAdder FA2(sw[2],sw[6],c[1],led[2],c[2]);
FullAdder FA3(sw[3],sw[7],c[2],led[3],led[4]);

endmodule 