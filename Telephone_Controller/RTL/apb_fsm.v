module apb_fsm #(parameter DATA_WIDTH=32,ADDR_WIDTH=32)       (input pclk,
							       input presetn,
							       input psel,
							       input penable,
							       input pwrite,
							       input [ADDR_WIDTH-1:0] paddr,
							       input [DATA_WIDTH-1:0] pwdata,
							       output reg wr_en,
							       output reg rd_en,
							       output pready,
							       output [DATA_WIDTH-1:0] wr_data,
							       output [ADDR_WIDTH-1:0] addr
							       );
							       
							       
reg [1:0] pstate,nstate;
parameter [1:0] IDLE=2'b00,SETUP=2'b01,WAIT=2'b10;							       

//pstate
always @(posedge pclk,negedge presetn)
begin
if(!presetn)
pstate <= IDLE;
else
pstate <= nstate;
end


//nstate

always @(*)
begin

casez(pstate)
IDLE:nstate <= psel?SETUP:IDLE;
SETUP:nstate <= psel?(penable?WAIT:SETUP):IDLE;
WAIT:nstate<= (psel&penable)?SETUP:IDLE;
endcase 

end


//output

always@(*)
begin
casez(pstate)
IDLE: begin
wr_en=0;
rd_en=0;
end
SETUP:begin
wr_en=pwrite;
rd_en=~pwrite;
end
WAIT:begin
wr_en=0;
rd_en=0;
end
endcase
end

assign pready=1;
assign wr_data=pwdata;
assign addr=paddr;
endmodule
