module array_tb;

    // Inputs
    reg [7:0] data_in;       // 8-bit data input
    reg [7:0] select;        // 8-bit one-hot select for word modules
    reg rw;                  // Read/Write control

    // Output
    wire [7:0] data_out;     // 8-bit data output

    // Instantiate the array module
    array uut (
        .data_in(data_in),
        .select(select),
        .rw(rw),
        .data_out(data_out)
    );

    // Test procedure
    initial begin
        // Step 1: Initialize signals
        data_in = 8'b00000000;
        select = 8'b00000000;
        rw = 1'b0; // Default to read mode

        // Step 2: Write to each word module
        rw = 1'b1; // Enable write mode
        for (integer i = 0; i < 8; i = i + 1) begin
            select = 8'b00000001 << i;  // One-hot select for word i
            data_in = 8'b10101010 + i;  // Example data pattern for each word
            #10; // Wait to simulate write time
        end

        // Step 3: Read back each word module
        rw = 1'b0; // Enable read mode
        for (integer i = 0; i < 8; i = i + 1) begin
            select = 8'b00000001 << i;  // One-hot select for word i
            #10; // Wait to simulate read time
            $display("Read from word %0d: data_out = %b", i, data_out);
        end

        // End simulation
        $finish;
    end

endmodule