module word_tb;

    // Inputs and outputs
    reg i0, i1, i2, i3, i4, i5, i6, i7, rw, select; // Input signals
    wire o0, o1, o2, o3, o4, o5, o6, o7;           // Output signals

    // Instantiate the word module
    word uut (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .i4(i4), .i5(i5), .i6(i6), .i7(i7),
        .rw(rw), .select(select),
        .o0(o0), .o1(o1), .o2(o2), .o3(o3),
        .o4(o4), .o5(o5), .o6(o6), .o7(o7)
    );

    // Test procedure
    initial begin
        // Initialize inputs
        i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        i4 = 1; i5 = 0; i6 = 1; i7 = 0;
        rw = 0; select = 0;

        // Display header
        $display("Time\t rw select i0 i1 i2 i3 i4 i5 i6 i7 | o0 o1 o2 o3 o4 o5 o6 o7");

        // Perform write operation
        #10 rw = 1; select = 1;
        #10 $display("%0t\t %b   %b    %b  %b  %b  %b  %b  %b  %b  %b | %b  %b  %b  %b  %b  %b  %b  %b", 
                      $time, rw, select, i0, i1, i2, i3, i4, i5, i6, i7, o0, o1, o2, o3, o4, o5, o6, o7);

        // Perform read operation
        #10 rw = 0; select = 1;
        #10 $display("%0t\t %b   %b    %b  %b  %b  %b  %b  %b  %b  %b | %b  %b  %b  %b  %b  %b  %b  %b", 
                      $time, rw, select, i0, i1, i2, i3, i4, i5, i6, i7, o0, o1, o2, o3, o4, o5, o6, o7);

        // Disable select and observe output
        #10 select = 0;
        #10 $display("%0t\t %b   %b    %b  %b  %b  %b  %b  %b  %b  %b | %b  %b  %b  %b  %b  %b  %b  %b", 
                      $time, rw, select, i0, i1, i2, i3, i4, i5, i6, i7, o0, o1, o2, o3, o4, o5, o6, o7);

        // Change inputs and perform another write
        #10 i0 = 1; i1 = 0; i2 = 1; i3 = 0;
            i4 = 0; i5 = 1; i6 = 0; i7 = 1;
            rw = 1; select = 1;
        #10 $display("%0t\t %b   %b    %b  %b  %b  %b  %b  %b  %b  %b | %b  %b  %b  %b  %b  %b  %b  %b", 
                      $time, rw, select, i0, i1, i2, i3, i4, i5, i6, i7, o0, o1, o2, o3, o4, o5, o6, o7);

        // End simulation
        #10 $finish;
    end

endmodule