module decoder_tb;

    reg adr0, adr1, adr2, valid;

    wire o0, o1, o2, o3, o4, o5, o6, o7;

    // Instantiate the decoder
    decoder uut (
        .adr0(adr0),
        .adr1(adr1),
        .adr2(adr2),
        .valid(valid),
        .o0(o0),
        .o1(o1),
        .o2(o2),
        .o3(o3),
        .o4(o4),
        .o5(o5),
        .o6(o6),
        .o7(o7)
    );

    // Test procedure
    initial begin
        // Monitor the inputs and outputs
        $monitor("Time = %0t | valid = %b | adr2 = %b, adr1 = %b, adr0 = %b | o0 = %b, o1 = %b, o2 = %b, o3 = %b, o4 = %b, o5 = %b, o6 = %b, o7 = %b",
                 $time, valid, adr2, adr1, adr0, o0, o1, o2, o3, o4, o5, o6, o7);
        
        // Test with valid = 0 (outputs should all be zero)
        valid = 0;
        {adr2, adr1, adr0} = 3'b000;
        #10;

        // Set valid = 1 to enable outputs and test each address combination
        valid = 1;
        for (integer i = 0; i < 8; i = i + 1) begin
            {adr2, adr1, adr0} = i; // Concatenate i into adr2, adr1, adr0
            #10; // Wait for 10 time units
        end

        // Test with valid = 0 again (outputs should go back to zero)
        valid = 0;
        {adr2, adr1, adr0} = 3'b000;
        #10;

        // End simulation
        $finish;
    end

endmodule  