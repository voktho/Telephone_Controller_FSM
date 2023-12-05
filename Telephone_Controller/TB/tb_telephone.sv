module tb_telephone;

parameter ADDR_WIDTH=32,DATA_WIDTH=32;

reg pclk;
reg presetn;
reg psel;
reg penable;
reg pwrite;
reg [ADDR_WIDTH-1:0] paddr;
reg [DATA_WIDTH-1:0] pwdata;
reg  pickup_call;
reg end_call;
wire pready;
wire [DATA_WIDTH-1:0] prdata;
wire dial_tone;
wire dial_timeout;
wire in_call;
wire call_ended;
wire call_timeout;



telephone_top #(.DATA_WIDTH(32),.ADDR_WIDTH(32)) dut_tele_top(
								.pclk(pclk),
								.presetn(presetn),
								.psel(psel),
								.penable(penable),
								.pwrite(pwrite),
								.paddr(paddr),
								.pwdata(pwdata),
								.pickup_call(pickup_call),
								.pready(pready),
								.prdata(prdata),
								.dial_tone(dial_tone),
								.dial_timeout(dial_timeout),
								.in_call(in_call),
								.call_ended(call_ended),
								.call_timeout(call_timeout)
								);


initial begin

pclk <= 0;
presetn <= 0;
psel <=0;
penable <=0;
pwrite <=0;
paddr <= 32'h0;
pwdata <= 32'h0;
pickup_call <=0;
end_call <=0;

@(posedge pclk);
presetn <= 1;
psel <= 1;
penable <=0;
pwrite <=1;
paddr <= 32'h8;
pwdata <= 32'h5AB;
pickup_call <=1;
end_call <=0;

@(posedge pclk);
penable <=1;

@(posedge pclk);
presetn <= 1;
psel <= 1;
penable <=0;
pwrite <=0;
paddr <= 32'hC;
//pwdata <= 32'h5AB;
pickup_call <=1;
end_call <=0;
@(posedge pclk);
penable <=1;

#3000 $finish;
end

always  #5 pclk = ~pclk;



endmodule
