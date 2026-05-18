module nand3 (output Y, input A, B, C);	
    // 3-input NAND gate
    assign Y = ~(A & B & C);	
endmodule

module nand4 (output Y, input A, B, C, D);	  
    // 4-input NAND gate
    assign Y = ~(A & B & C & D);	
endmodule

module decoder (adr2, adr1, adr0, valid, o0, o1, o2, o3, o4, o5, o6, o7);
    // Inputs and outputs
    input adr2, adr1, adr0, valid; // Address inputs and valid signal
    output o0, o1, o2, o3, o4, o5, o6, o7; // Decoder outputs

    // Internal wires for intermediate signals
    wire nout1, nout2, nout3; // Inverted address inputs
    wire nandout1, nandout2, nandout3, nandout4, nandout5, nandout6, nandout7, nandout8;

    // Invert address inputs
    not(nout1, adr2);
    not(nout2, adr1);
    not(nout3, adr0);

    // Generate NAND outputs for each decoder state
    nand4 nand4_1(nandout1, adr2, adr1, adr0, valid); // Address 7
    nand4 nand4_2(nandout2, adr2, adr1, nout3, valid); // Address 6
    nand4 nand4_3(nandout3, adr2, nout2, adr0, valid); // Address 5
    nand4 nand4_4(nandout4, adr2, nout2, nout3, valid); // Address 4
    nand4 nand4_5(nandout5, nout1, adr1, adr0, valid); // Address 3
    nand4 nand4_6(nandout6, nout1, adr1, nout3, valid); // Address 2
    nand4 nand4_7(nandout7, nout1, nout2, adr0, valid); // Address 1
    nand4 nand4_8(nandout8, nout1, nout2, nout3, valid); // Address 0

    // Invert NAND outputs to generate final decoder outputs
    not(o7, nandout1); // Output for address 7
    not(o6, nandout2); // Output for address 6
    not(o5, nandout3); // Output for address 5
    not(o4, nandout4); // Output for address 4
    not(o3, nandout5); // Output for address 3
    not(o2, nandout6); // Output for address 2
    not(o1, nandout7); // Output for address 1
    not(o0, nandout8); // Output for address 0

endmodule
