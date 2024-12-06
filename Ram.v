module Ram (din,clk,rst_n,rx_valid,dout,tx_valid);
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;
input clk,rst_n,rx_valid;
input [9:0] din;
output reg [ADDR_SIZE-1:0] dout;
output reg tx_valid;
reg [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];
reg [ADDR_SIZE-1:0] hold_read_write;

always @(posedge clk) begin
if (~rst_n)
dout <= 0;
else
case (din[9:8])
0 : if (rx_valid) begin
    hold_read_write <= din[7:0];
    tx_valid <= 0;
end

1 : if (rx_valid) begin
    mem[hold_read_write] <= din[7:0];
    tx_valid <= 0;
end

2 : begin 
    hold_read_write <= din[7:0];
    tx_valid <= 1;
end

3 : begin
    dout <= mem[hold_read_write];
    tx_valid <= 1;
end
endcase
end
endmodule