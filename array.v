module array (
    input [7:0] data_in,      // 8-bit data input for writing to a word
    input [7:0] select,       // 8-bit one-hot select input, each bit selects a word module
    input rw,                 // Read/Write control signal
    output [7:0] data_out     // 8-bit data output for reading from a selected word
);

    // Internal wires to capture outputs from each word module
    wire [7:0] word_out [7:0];  // Array of outputs from each word module

    // Generate block to instantiate each word module
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : word_array
            word word_inst (
                .i0(data_in[0]), .i1(data_in[1]), .i2(data_in[2]), .i3(data_in[3]),
                .i4(data_in[4]), .i5(data_in[5]), .i6(data_in[6]), .i7(data_in[7]),
                .rw(rw),
                .select(select[i]),  // Select line for each word module
                .o0(word_out[i][0]), .o1(word_out[i][1]), .o2(word_out[i][2]), .o3(word_out[i][3]),
                .o4(word_out[i][4]), .o5(word_out[i][5]), .o6(word_out[i][6]), .o7(word_out[i][7])
            );
        end
    endgenerate

    // Multiplex the outputs of each word module based on the select line
    assign data_out = (select[0] ? word_out[0] :
                       select[1] ? word_out[1] :
                       select[2] ? word_out[2] :
                       select[3] ? word_out[3] :
                       select[4] ? word_out[4] :
                       select[5] ? word_out[5] :
                       select[6] ? word_out[6] :
                       select[7] ? word_out[7] : 8'b00000000);

endmodule