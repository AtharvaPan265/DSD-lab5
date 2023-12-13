
module register_file(

	input  wire        clk, rst,
	input  wire [4:0]  A1, A2, A3, // A1, A2, A3 are the address
	input  wire [31:0] WD3, 		  //data from data memory
	input  wire 	     WE3, 		  //WE3 = 1, write register file
	output wire [31:0] RD1, 		  //output port one for register file
	output wire [31:0] RD2, 		  //output port two for register file
	output wire [31:0] probe 		  //probe to check the result in the register file
	
);

logic [31:0] registers[31:0];
assign probe = registers[1];
assign RD1 = registers[A1];
assign RD2 = registers[A2];

always_ff@(posedge clk or negedge rst) begin
	if (!rst) begin
		for (int i = 0 ;  i < 32 ; i++) begin
				registers[i] <= i;
			end
	end else begin
		if (!WE3) begin
			registers[1] <= WD3;
		end
	end
end
endmodule

module ALU(
	input  wire [31:0] SrcA,
	input  wire [31:0] SrcB,
	input  wire [2:0]  ALUControl,
	output wire [31:0] ALUResult
);

always_comb begin
	case(ALUControl)
		3'b010:ALUResult = SrcA + SrcB;
		3'b110:ALUResult = SrcA - SrcB;
		default: ALUResult = 31'b0;
	endcase
end
endmodule

module display(
input  wire [6:0] in,
output wire [6:0] seven_seg
);
always_comb begin
	case (in)
		7'b0000000: seven_seg = 7'b1000000; //0
		7'b0000001: seven_seg = 7'b1111001; //1
		7'b0000010: seven_seg = 7'b0100100; //2
		7'b0000011: seven_seg = 7'b0110000; //3
		7'b0000100: seven_seg = 7'b0011001; //4
		7'b0000101: seven_seg = 7'b0010010; //5
		7'b0000110: seven_seg = 7'b0000010; //6
		7'b0000111: seven_seg = 7'b1111000; //7
		7'b0001000: seven_seg = 7'b0000000; //8
		7'b0001001: seven_seg = 7'b0011000; //9
		7'b0001010: seven_seg = 7'b0001000; //a
		7'b0001011: seven_seg = 7'b0000011; //b
		7'b0001100: seven_seg = 7'b0100111; //c
		7'b0001101: seven_seg = 7'b0100001; //d
		7'b0001110: seven_seg = 7'b0000110; //e
		7'b0001111: seven_seg = 7'b0001110; //f
		default: seven_seg = 7'b1;
	endcase
end
endmodule

module top(
input  clk, rst,
input  [1:0] sw, //address for instruction memory
output [31:0] ALUResult, //output for pre-lab simulation
output [31:0] RD1, RD2, //output for pre-lab simulation
output [31:0] probe_register_file, //output for pre-lab simulation
output [6:0] display_led //output for in-lab
);

wire[31:0] inst_0 = 32'b0;
wire[31:0] inst_1 = 32'b100100_01000_00010_00001_0000_0000_000; 
//add rf_regs[5] and rf_regs[4] to rf_regs[1];
wire[31:0] inst_2 = 32'b101100_01000_00011_00001_0000_0000_000; 
//sub rf_regs[10] - rf_regs[8] to rf_regs[1];
wire[31:0] inst_ex;
assign inst_ex = (sw==1)? inst_1:(sw==2)? inst_2: inst_0;


register_file r_f(.clk(clk),.rst(rst),
.A1(inst_ex[25:21]),.A2(inst_ex[20:16]),.A3(inst_ex[15:11]),
.WD3(ALUResult),
.WE3(1),
.RD1(RD1),
.RD2(RD2),
.probe(probe_register_file)
);


ALU t1(
.SrcA(RD1),
.SrcB(RD2),
.ALUControl(inst_ex[29:27]),
.ALUResult(ALUResult)
);

display t2(ALUResult, display_led);

endmodule



