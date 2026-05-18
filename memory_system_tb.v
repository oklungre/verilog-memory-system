module memory_system_tb;

    // Inputs to the MemorySystem
    reg clk;
    reg op;                  // Operation control for the FSM
    reg select;              // Select signal for the FSM
    reg [2:0] address;       // 3-bit address to select a word in the array
    reg [7:0] data_in;       // 8-bit data input

    // Output from the MemorySystem
    wire [7:0] data_out;     // 8-bit data output

    // ASCII codes for "Christian"
    reg [7:0] ascii_values [0:8];

    // Instantiate the MemorySystem
    MemorySystem uut (
        .clk(clk),
        .op(op),
        .select(select),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    // Force initial state for FSM
    initial begin
        // Force the initial state of FSM's internal state variables A and B to 0
        force uut.fsm_inst.A = 0;
        force uut.fsm_inst.B = 0;
        #1; // Small delay to allow initial conditions to take effect
        release uut.fsm_inst.A;
        release uut.fsm_inst.B;
    end

    // Test procedure
    initial begin
        // Initialize ASCII codes for "Christian"
        ascii_values[0] = 8'b01000011; // C
        ascii_values[1] = 8'b01101000; // h
        ascii_values[2] = 8'b01110010; // r
        ascii_values[3] = 8'b01101001; // i
        ascii_values[4] = 8'b01110011; // s
        ascii_values[5] = 8'b01110100; // t
        ascii_values[6] = 8'b01101001; // i
        ascii_values[7] = 8'b01100001; // a
        ascii_values[8] = 8'b01101110; // n

        // Display header
        $display("Time\tAddress\tData In\t\tData Out\tOperation");

        // Step 1: Write ASCII values to each address in the array
        select = 1;   // Enable FSM
        op = 1;       // Set FSM to write mode
        for (integer i = 0; i < 9; i = i + 1) begin
            address = i[2:0];     // Set address (loops from 0 to 7 with 3-bit wraparound)
            data_in = ascii_values[i]; // Write ASCII code for each character
            #10;                      // Wait to simulate write time
            $display("%0t\t%b\t%b\t\t%b\t\tWrite", $time, address, data_in, data_out);
        end

        // Step 2: Read ASCII values from each address in the array
        op = 0;       // Set FSM to read mode
        for (integer i = 0; i < 9; i = i + 1) begin
            address = i[2:0];     // Set address to read (same addresses as write phase)
            #10;                  // Wait to simulate read time
            $display("%0t\t%b\t%b\t\t%b\t\tRead", $time, address, data_in, data_out);
        end

        // End simulation
        $finish;
    end

endmodule



