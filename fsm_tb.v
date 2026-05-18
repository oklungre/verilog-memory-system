module fsm_tb;

    reg op, select, clk;   
    wire valid, rw;  

    // Instantiate the FSM
    fsm uut (
        .valid(valid),  
        .rw(rw),        
        .op(op),        
        .select(select),
        .clk(clk)
    );

    // Clock generation
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    // Force initial state
    initial begin
        // Force the initial state of A and B to 0 at time zero
        force uut.A = 0;
        force uut.B = 0;
        #1; // Wait for a short time to apply initial conditions
        release uut.A;
        release uut.B;
    end

    // Test sequence
    initial begin
        // Display header for output
        $display("Time\top\tselect\tA\tB\tvalid\trw");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b", $time, op, select, uut.A, uut.B, valid, rw);

        // Initialize inputs
        op = 0; select = 0;
        
        // Test each combination of inputs at various states
        #10; op = 0; select = 0; // Initial state check
        #10; op = 0; select = 1;
        #10; op = 1; select = 0;
        #10; op = 1; select = 1;

        // Simulate transitions across all states
        #10; op = 0; select = 0;
        #10; op = 0; select = 1;
        #10; op = 1; select = 0;
        #10; op = 1; select = 1;

        // Additional tests to confirm behavior
        #10; op = 1; select = 0;
        #10; op = 0; select = 1;
        #10; op = 0; select = 0;
        #10; op = 1; select = 1;

        // End simulation
        #10;
        $finish;
    end

endmodule