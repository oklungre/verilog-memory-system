module memory_system (
    input clk,                // Clock signal
    input op,                 // Operation control signal (write or read mode)
    input select,             // Selection signal for the FSM
    input [2:0] address,      // 3-bit address for selecting one of 8 word modules
    input [7:0] data_in,      // 8-bit data input for writing to the array
    output [7:0] data_out     // 8-bit data output for reading from the array
);

    // Internal connections
    wire valid, rw;           // Control signals from FSM
    wire [7:0] decoder_out;   // Decoder outputs to select array word

    // Instantiate the FSM
    fsm fsm_inst (
        .valid(valid),        // FSM output, used as enable signal for decoder
        .rw(rw),              // FSM output, determines read or write mode
        .op(op),              // Operation input to FSM
        .select(select),      // Selection input to FSM
        .clk(clk)             // Clock input to FSM
    );

    // Instantiate the Decoder
    decoder decoder_inst (
        .adr2(address[2]),
        .adr1(address[1]),
        .adr0(address[0]),
        .valid(valid),        // Use FSM's `valid` output as decoder enable
        .o0(decoder_out[0]),
        .o1(decoder_out[1]),
        .o2(decoder_out[2]),
        .o3(decoder_out[3]),
        .o4(decoder_out[4]),
        .o5(decoder_out[5]),
        .o6(decoder_out[6]),
        .o7(decoder_out[7])
    );

    // Instantiate the Array
    array array_inst (
        .data_in(data_in),    // Data input to array
        .select(decoder_out), // Decoder output used as select input to array
        .rw(rw),              // Read/Write signal from FSM
        .data_out(data_out)   // Data output from array
    );

endmodule