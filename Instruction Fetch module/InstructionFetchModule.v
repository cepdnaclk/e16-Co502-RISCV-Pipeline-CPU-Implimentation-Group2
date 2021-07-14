module InstructionfetchModule (
    RESET,
    instruction_mem_busywait,
    data_mem_busywait,
    jump_branch_signal,
    PC

);

output reg [31:0] PC,INCREMENTED_PC_by_four;
input wire CLK,RESET,instruction_mem_busywait,data_mem_busywait,jump_branch_signal;

wire busywait;
wire [31:0] Jump_Branch_PC;


// busywait signal enable whenever data memmory busywait or instruction memory busywait enables
or(busywait,instruction_mem_busywait,data_mem_busywait);


always @(RESET) begin //set the pc value depend on the RESET to start the programme
    PC=0;
end

// incrementing PC by 4 to get next PC value
always @(PC) begin
    INCREMENTED_PC_by_four=PC+4;
end


always @(posedge CLK) begin //update the pc value depend on the positive clock edge
    if(busywait==1'b0)begin //update the pc when only busywait is zero 
        case (jump_branch_signal)
            1'b1:begin
                PC=Jump_Branch_PC;
            end
            1'b0:begin
                PC=INCREMENTED_PC_by_four;
            end
        endcase
    end
end  
    
endmodule