module register(
input clk, rst,
input wire [4:0] a1, a2, a3,
input wire [31:0] wd3,
input wire we3,
output wire [31:0] rd1,
output wire [31:0] rd2,
output wire [31:0] probe
);

reg [31:0] registers[31:0];

assign rd1   = registers[a1];
assign rd2   = registers[a2];
assign probe = registers[a3];

initial begin

	for (int i = 0 ; i < 32 ; i++) begin
	
		registers[i] = 1'b0;
	
	end

end

always @(posedge clk or posedge rst) begin

	if(rst) begin
		
		for (int i = 0 ; i < 32 ; i++) begin
			
			registers[i] = 32'b0;
		
		end
		
	end else begin
		
		if (we3) begin
				
			registers[a3] <= wd3; 
		
		end
		
	end
	
end

endmodule
