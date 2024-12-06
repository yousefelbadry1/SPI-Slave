module SPI_SLAVE (MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid);
parameter IDLE = 3'b000,
          CHK_CMD = 3'b001,
          READ_ADD = 3'b010,
          READ_DATA = 3'b011,
          WRITE = 3'b100;
input MOSI,clk,rst_n,tx_valid,SS_n;
input [7:0] tx_data; reg [7:0] shift_value;
output reg MISO,rx_valid;
output reg [9:0] rx_data;
(*fsm_encoding="sequential"*)
reg [2:0] cs,ns;
reg [3:0] counter_write;
reg [4:0] counter_read;
reg [9:0] serial_2_parallel;


//state memory
always @(posedge clk) begin
if (~rst_n)
	cs <= IDLE;
else
	cs <= ns;
end


//next stat logic
always @(cs,SS_n) begin
case (cs)
IDLE : if (SS_n)
       		ns = IDLE;
       else
       		ns = CHK_CMD;

CHK_CMD:begin 
	 if (SS_n)
        	ns = IDLE;
        else if (MOSI) 
        begin
            if (tx_valid) 
        		ns = READ_DATA; 
            else 
        		ns = READ_ADD; 	
        end
        else
        	ns = WRITE;
        end

READ_ADD : if (SS_n)
           		ns = IDLE;
           else if (counter_write < 10)
           		ns = READ_ADD;

READ_DATA :if (SS_n)
            	ns = IDLE;
           else if (counter_read < 18)
            	ns = READ_DATA;

WRITE : if (SS_n)
        	ns = IDLE;
        else if (counter_write < 10)
        	ns = WRITE;
endcase
end

//output logic
always @(posedge clk) 
begin
if (~rst_n) 
begin
	counter_write <= 0; 
	counter_read <= 0; 
	rx_data <= 0; 
	serial_2_parallel <= 0;
end

else if ((cs == WRITE) || (cs == READ_ADD) || ((cs == READ_DATA) && (counter_read <= 10)) && (~SS_n))
begin
serial_2_parallel <= {serial_2_parallel[8:0],MOSI};
counter_write <= counter_write + 1;

if (cs == READ_DATA)
counter_read <= counter_read + 1;

if (counter_write == 10) begin
rx_valid <= 1;
rx_data <= serial_2_parallel;
counter_write <= 0;
serial_2_parallel <= 0;
end
end

else if ((cs == (READ_DATA)) && (~SS_n) && (counter_read > 10))
begin
	if (tx_valid)
	begin
shift_value <= counter_read-11;
MISO <= tx_data >> shift_value;
counter_read <= counter_read + 1;	
	end
	if (counter_read == 18) 
		counter_read <= 0;
end

else begin
counter_read <= 0;
counter_write <= 0;
end
end
endmodule