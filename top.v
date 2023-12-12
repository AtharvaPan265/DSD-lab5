module top(
input clk, rst,
input[1:0] sw, //address for instruction memory
output [31:0] ALUResult, //output for pre-lab simulation
output [31:0] RD1, RD2, //output for pre-lab simulation
output [31:0] probe_register_file, //output for pre-lab simulation
output [6:0] display_led //output for in-lab
);

wire[31:0] inst_0 = 32'b0;
wire[31:0] inst_1 = 32'b100100_00101_00100_00001_0000_0000_000; 
//add rf_regs[5] and rf_regs[4] to rf_regs[1];
wire[31:0] inst_2 = 32'b101100_01010_01000_00001_0000_0000_000; 
//sub rf_regs[10] - rf_regs[8] to rf_regs[1];
wire[31:0] inst_ex;
assign inst_ex = (sw==1)? inst_1:(sw==2)? inst_2: inst_0;


register r_f(.clk(clk),.rst(rst),
.a1(inst_ex[25:21]),.a2(inst_ex[20:16]),.a3(inst_ex[15:11]),
.wd3(ALUResult),
.we3(1),
.rd1(RD1),
.rd2(RD2),
.probe(probe_register_file)
);


alu t1(
.srca(RD1),
.srcb(RD2),
.opcode(inst_ex[29:27]),
.aluout(ALUResult)
);

//display t2(.data_in(probe_register_file), 
//.segments(display_led));

endmodule



