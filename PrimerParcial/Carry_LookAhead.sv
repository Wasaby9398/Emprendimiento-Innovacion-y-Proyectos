`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UMG
// Engineer: ALEJANDRO DE LEÓN
// 
// Create Date: 04.03.2024 01:58:00
// Design Name: CARRYLOOKAHEAD
// Module Name: CarryLookahead
// Project Name: Parcial 1
// Target Devices: basys3
// Tool Versions: 
// Description: Program of CarryLookahead, estrategia 2 [Bloque combinacional + circuiteria externa]
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CarryLookahead(
    input  P0, P1, P2, P3, G0, G1, G2, G3, Cin,
    output C0, C1, C2, C3, C4
    );
    
    logic w0,w1,w2,w3,w4,w5,w6,w7,w8,w9;
    
    assign C0 = Cin;
    assign C1 = w0 | G0;
    assign C2 = w1 | w2 | G1;
    assign C3 = w3 | w4 | w5 | G2;
    assign C4 = w6 | w7 | w8 | w9 | G3;
    
    assign w0 = Cin  & P0;
    assign w1 = P1 & w0;
    assign w2 = P1 & G0;
    assign w3 = w1   & P2;
    assign w4 = w2   & P2;
    assign w5 = G1   & P2;
    assign w6 = w3   & P3;
    assign w7 = w4   & P3; 
    assign w8 = w5   & P3;
    assign w9 = P3   & G2;    

endmodule

module ExternalCircuit(
 input [8:0]sw, //0-3A, 4-7B, 8Cin
 output [4:0]led //S0,S1,S2,S3,Cout
);

 logic p0,p1,p2,p3;
 logic g0,g1,g2,g3;
 logic c0,c1,c2,c3,c4; 
 wire [5:0]x;
 
assign p0 = sw[0] ^ sw[4];
assign p1 = sw[1] ^ sw[5];
assign p2 = sw[2] ^ sw[6];
assign p3 = sw[3] ^ sw[7];


assign g0 = sw[0] & sw[4];
assign g1 = sw[1] & sw[5];
assign g2 = sw[2] & sw[6];
assign g3 = sw[3] & sw[7];

CarryLookahead CLA0(p0, p1, p2, p3, g0, g1, g2, g3, sw[8], c0 , c1, c2, c3, c4);

assign led[0]= c0 ^ p0;
assign led[1]= c1 ^ p1;
assign led[2]= c2 ^ p2;
assign led[3]= c3 ^ p3;
assign led[4]= c4;
 
endmodule