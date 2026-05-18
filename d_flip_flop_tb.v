module d_flip_flop_tb;

    // Inputs and output for the testbench
    reg D, clk;        // Testbench inputs: D (data) and clk (clock)
    wire Q;            // Output of the D flip-flop

    // Instantiate the D flip-flop
    d_flip_flop uut (
        .D(D),         // Connect testbench D to flip-flop input
        .clk(clk),     // Connect testbench clk to flip-flop clock
        .Q(Q)          // Observe flip-flop output Q
    );

    // Clock generation
    initial begin
        clk = 0;               // Initialize clock to 0
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test stimulus
    initial begin
        $monitor("Time: %0d, D: %b, clk: %b, Q: %b", $time, D, clk, Q); // Display signals

        // Apply test inputs
        D = 0;  #10;           // Set D to 0, wait 10 time units
        D = 1;  #10;           // Set D to 1, wait 10 time units
        D = 0;  #10;           // Set D to 0, wait 10 time units
        D = 1;  #10;           // Set D to 1, wait 10 time units
        D = 0;  #10;           // Set D to 0, wait 10 time units

        #10 $finish;           // End simulation
    end

endmodule