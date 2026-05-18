module bitcell (inp, rw, select, outp);
    // Inputs and output
    input inp, rw, select; // Input data (inp), Read/Write control (rw), and enable (select)
    output outp;           // Output of the bitcell

    // Internal wires
    wire not_out, nand1_out, nand2_out, nand3_out, nand4_out, d_out;

    // Logic for read/write operations
    not(not_out, rw);                   // Invert rw
    nand(nand1_out, d_out, not_out);    // Store existing data when rw is low
    nand(nand2_out, inp, rw);           // Write new data when rw is high
    nand(nand3_out, nand1_out, nand2_out); // Combine read and write signals

    // Store data using a latch
    d_latch latch(.data(nand3_out), .store(select), .out(d_out)); // Latch stores the bit

    // Generate output
    nand(nand4_out, d_out, select);     // Control output with select
    not(outp, nand4_out);               // Invert for final output

endmodule