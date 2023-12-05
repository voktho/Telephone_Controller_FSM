module comparator #(parameter COMP_WIDTH=8) (input [COMP_WIDTH-1:0] count,
					    input [COMP_WIDTH-1:0] comp_with,
					    output comp_val);
					   
assign comp_val=(count==comp_with);

endmodule
