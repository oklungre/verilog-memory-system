module d_flip_flop (D, clk, Q);
    // Inputs and output
    input D, clk;     // Input data and clock signal
    output Q;         // Output of the flip-flop
    wire D, clk, Q;   // Wires for inputs and output

    // Internal wire for master-slave connection
    wire nclk, latch_out;

    // Invert clock signal for master latch
    not(nclk, clk);

    // Master latch (stores data when clock is low)
    d_latch latch_1(
        .data(D),
        .store(nclk),
        .out(latch_out)
    );

    // Slave latch (stores data when clock is high)
    d_latch latch_2(
        .data(latch_out),
        .store(clk),
        .out(Q)
    );

endmodule