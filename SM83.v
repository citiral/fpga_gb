module SM83(

	// CLOCK //
	CLOCK,
	
	// RESET //
	RESET,
	
	// SRAM //
	SRAM_ADDRESS,
	SRAM_DATA,
	SRAM_Q,
	SRAM_WREN,
	
	LED_DEBUG,
	
);

// Parameters of the module
input  wire        CLOCK;
input  wire        RESET;
output reg  [12:0] SRAM_ADDRESS;
inout  reg  [7:0]  SRAM_DATA;
input  wire [7:0]  SRAM_Q;
output reg         SRAM_WREN;
output reg 	[7:0]  LED_DEBUG;

// CPU registers
reg [7:0] REG_A;
reg [7:0] REG_B;
reg [7:0] REG_C;
reg [7:0] REG_D;
reg [7:0] REG_E;
reg [7:0] REG_H;
reg [7:0] REG_L;
reg [7:0] REG_F;
reg [15:0] REG_PC;
reg [15:0] REG_SP;
wire VIEW_AF = REG_A << 8 + REG_F;
wire VIEW_BC = REG_B << 8 + REG_C;
wire VIEW_DE = REG_D << 8 + REG_E;
wire VIEW_HL = REG_H << 8 + REG_L;

// CPU internals
reg [3:0] stage;
reg [7:0] opcode;

parameter STAGE_NO_INSTR_INSTR_FETCH=0, STAGE_EXEC_0=1, STAGE_EXEC_1=1;


/*
 * Begins fetching the next instruction. To be called at the last stage of an instruction
 */
task start_instruction_fetch();
begin
	SRAM_WREN = 0;
	SRAM_ADDRESS = REG_PC[12:0];
end
endtask


always @(posedge CLOCK, negedge RESET) begin
		if (RESET == 1'b0) begin
			REG_A = 0;
			REG_B = 0;
			REG_C = 0;
			REG_D = 0;
			REG_E = 0;
			REG_H = 0;
			REG_L = 0;
			REG_PC = 0;
			REG_SP = 0;
			stage = STAGE_NO_INSTR_INSTR_FETCH; 
		end
		
		
		case (stage)
			STAGE_NO_INSTR_INSTR_FETCH: begin
				start_instruction_fetch();
				stage = STAGE_EXEC_0;
			end
			
			STAGE_EXEC_0: begin
				opcode = SRAM_Q;
				LED_DEBUG = opcode;
				stage = STAGE_NO_INSTR_INSTR_FETCH;
			end
		endcase
end




endmodule
