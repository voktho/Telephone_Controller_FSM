module counter#(parameter COUNT_WIDTH=8)(input pclk,
	       input presetn,
	       input clear,
	       output reg [COUNT_WIDTH-1:0] count=0);
	       
always @(posedge pclk,negedge presetn)
begin
if(~presetn)
count <= 'b0;
else
count <= clear? 'b0:(count+1);
end
endmodule
