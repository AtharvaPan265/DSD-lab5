module testbench_top();

reg clk, rst;
reg[1:0] sw; //address for instruction memory
wire[31:0] ALUResult;
wire[31:0] RD1, RD2;
wire[31:0] probe_register_file;

top uut(
	.clk(clk),
	.rst(rst),
	.sw(sw), //address for instruction memory
	.ALUResult(ALUResult),
	.RD1(RD1), 
	.RD2(RD2),
	.probe_register_file(probe_register_file)
);
/*
initial begin
	rst <= 0;
	#50 rst <= 1;
end*/

initial begin
	clk <= 0;
	
end
always #25 clk <= ~clk;
initial begin
	sw <= 0;
	#100
	sw <= 1;
	#100
	sw <= 2;
end

endmodule
