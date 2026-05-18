module tb_bitcell;

    // Inputs and output for the testbench
    reg inp, rw, select;  // Testbench inputs: data (inp), Read/Write (rw), enable (select)
    wire outp;            // Output of the bitcell under test

    // Instantiate the bitcell
    bitcell uut(.inp(inp), .rw(rw), .select(select), .outp(outp));

    // Testbench logic
    initial begin
        // Initialize inputs
        inp = 0;
        rw = 0;
        select = 1;
        #10;

        // Test writing '1' to the bitcell
        inp = 1; rw = 1;   // Write operation
        #10;
        rw = 0;            // Read operation
        #10;
        $display("Output after writing '1': %b", outp);
        #10;

        // Disable select and check output
        select = 0;
        #10;
        $display("Output after setting select to '0': %b", outp);
        #10;

        // Re-enable select and test writing '0'
        select = 1;
        #10;
        inp = 0; rw = 1;   // Write '0' operation
        #10;
        rw = 0;            // Read '0' from the bitcell
        #10;
        $display("Output after writing '0': %b", outp);
        #10;

        // Disable select and check output again
        select = 0;
        #10;
        $display("Output after setting select to '0': %b", outp);

        $finish;           // End the simulation
    end

endmodule