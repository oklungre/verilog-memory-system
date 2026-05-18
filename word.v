module word (i0, i1, i2, i3, i4, i5, i6, i7, rw, select, o0, o1, o2, o3, o4, o5, o6, o7);
    // Inputs: 8 data bits and control signals
    input i0, i1, i2, i3, i4, i5, i6, i7, rw, select;
    output o0, o1, o2, o3, o4, o5, o6, o7; // Outputs: 8 data bits
    wire i0, i1, i2, i3, i4, i5, i6, i7, rw, select, o0, o1, o2, o3, o4, o5, o6, o7;

    // 8 bitcells for 8 bits
    bitcell bitcell0(.inp(i0), .rw(rw), .select(select), .outp(o0));
    bitcell bitcell1(.inp(i1), .rw(rw), .select(select), .outp(o1));
    bitcell bitcell2(.inp(i2), .rw(rw), .select(select), .outp(o2));
    bitcell bitcell3(.inp(i3), .rw(rw), .select(select), .outp(o3));
    bitcell bitcell4(.inp(i4), .rw(rw), .select(select), .outp(o4));
    bitcell bitcell5(.inp(i5), .rw(rw), .select(select), .outp(o5));
    bitcell bitcell6(.inp(i6), .rw(rw), .select(select), .outp(o6));
    bitcell bitcell7(.inp(i7), .rw(rw), .select(select), .outp(o7));

endmodule