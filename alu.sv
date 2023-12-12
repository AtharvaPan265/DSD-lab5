module alu(
input  [31:0] srca, srcb,
input  [2:0]  opcode,
output [31:0] aluout
);

initial begin

	aluout = 32'b0;

end

always @(opcode, srca, srcb) begin

	case (opcode)
		
			3'b010: aluout <= srca + srcb;
			
			3'b110: aluout <= srca - srcb;
			
			default: aluout <= 32'b0;
			
	endcase

end

endmodule
