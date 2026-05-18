module d_latch (data, store, out);
    // Inputs and output
    input data, store;  // Input data and enable signal
    output out;         // Output of the latch
    wire data, store, out; // Internal wires for inputs and output

    // Internal wires for latch logic
    wire onot, onand1, onand2, onand3;

    // Logic for the D latch
    not(onot, data);                // Invert data
    nand(onand1, data, store);      // First NAND gate
    nand(onand2, onot, store);      // Second NAND gate
    nand(out, onand1, onand3);      // Output feedback loop
    nand(onand3, out, onand2);      // Feedback to maintain state

endmodule	 