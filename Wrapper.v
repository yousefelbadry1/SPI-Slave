module Wrapper (MOSI,MISO,SS_n,clk,rst_n);
input MOSI,SS_n,clk,rst_n;
output MISO;
wire [9:0] rx_data; wire rx_valid; wire [7:0] tx_data; wire tx_valid;
SPI_SLAVE m1 (MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid);
Ram m2 (rx_data,clk,rst_n,rx_valid,tx_data,tx_valid);
endmodule