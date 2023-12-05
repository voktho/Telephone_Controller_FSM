module telephone_fsm(input pclk,
		     input presetn,
		     input dial,
		     input pickup_call,
		     input end_call,
		     input count_eql_5,
		     input count_eql_250,
		     input cancel,
		     output reg	dial_tone,
		     output reg	in_call,
		     output reg	dial_timeout,
		     output reg	call_ended,
		     output reg	call_timeout,
		     output reg clear
		     );


reg [2:0] pstate,nstate;
parameter [2:0] IDLE=3'b000,DIAL=3'b001,IN_CALL=3'b010,DIAL_TIME_OUT=3'b011,END_CALL=3'b100,CALL_TIME_OUT=3'b101;

//pstate

always @(posedge pclk,negedge presetn)
begin
if(~presetn)
pstate <= IDLE;
else 
pstate <= nstate;
end

//nstate

always @(*)
begin
casez(pstate)
IDLE: nstate <= dial?DIAL:IDLE;
DIAL: nstate <= pickup_call?IN_CALL:(count_eql_5?DIAL_TIME_OUT:DIAL);
IN_CALL: nstate <= end_call?END_CALL:(count_eql_250?CALL_TIME_OUT:IN_CALL);
END_CALL: nstate <= IDLE;
DIAL_TIME_OUT: nstate <= cancel?IDLE:DIAL_TIME_OUT;
CALL_TIME_OUT: nstate <= cancel?IDLE:CALL_TIME_OUT;
endcase
end 

//output


always @(*)
begin
casez(pstate)
IDLE:
	begin
	dial_tone=0;
	in_call=0;
	dial_timeout=0;
	call_ended=0;
	call_timeout=0;
	clear=1;
	end
DIAL:
	begin
	dial_tone=1;
	in_call=0;
	dial_timeout=0;
	call_ended=0;
	call_timeout=0;
	clear=0;
	end

IN_CALL:
	begin
	dial_tone=0;
	in_call=1;
	dial_timeout=0;
	call_ended=0;
	call_timeout=0;
	clear=0;
	end
END_CALL:
	begin
	dial_tone=0;
	in_call=0;
	dial_timeout=0;
	call_ended=1;
	call_timeout=0;
	clear=1;
	end
DIAL_TIME_OUT:
	begin
	dial_tone=0;
	in_call=0;
	dial_timeout=1;
	call_ended=0;
	call_timeout=0;
	clear=1;
	end
	
CALL_TIME_OUT:
	begin
	dial_tone=0;
	in_call=0;
	dial_timeout=0;
	call_ended=1;
	call_timeout=1;
	clear=1;
	end
endcase 
end
	
endmodule
