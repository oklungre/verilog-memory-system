module fsm (
    output valid, rw,        // Outputs: valid and rw signals
    input op, select, clk    // Inputs: op, select, and clock signal
);

    // State variables
    wire A, B;                // Current state bits
    wire D_A, D_B;            // Next state bits

    // Instantiate D flip-flops for state storage
    d_flip_flop dff1(.Q(A), .D(D_A), .clk(clk)); // Flip-flop for state bit A
    d_flip_flop dff2(.Q(B), .D(D_B), .clk(clk)); // Flip-flop for state bit B

    // Logic for D_A = A*op' + A*select' + B*op' + B*select'
    wire not_op, not_select;
    not (not_op, op);          // Inverted op
    not (not_select, select);  // Inverted select

    wire term1_DA, term2_DA, term3_DA, term4_DA;
    nand (term1_DA, A, not_op);        // Term: A * op'
    nand (term2_DA, A, not_select);    // Term: A * select'
    nand (term3_DA, B, not_op);        // Term: B * op'
    nand (term4_DA, B, not_select);    // Term: B * select'
    nand4 nand4_1(D_A, term1_DA, term2_DA, term3_DA, term4_DA); // Combine terms for D_A

    // Logic for D_B = A'B' + select'
    wire not_A, not_B;
    not (not_A, A);              // Inverted A
    not (not_B, B);              // Inverted B

    wire term1_DB;
    nand (term1_DB, not_A, not_B); // Term: A'B'
    nand (D_B, term1_DB, select); // Combine terms for D_B

    // Output logic
    not (valid, B);    // valid = B'
    not (rw, A);       // rw = A'

endmodule