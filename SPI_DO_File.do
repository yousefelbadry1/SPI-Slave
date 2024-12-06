vlib work
vlog Wrapper.v Wrapper_tb.v
vsim work.Wrapper_tb
add wave *
add wave -position end  sim:/Wrapper_tb/Dut/rx_data
add wave -position end  sim:/Wrapper_tb/Dut/rx_valid
add wave -position end  sim:/Wrapper_tb/Dut/tx_data
add wave -position end  sim:/Wrapper_tb/Dut/tx_valid
add wave -position end  sim:/Wrapper_tb/Dut/m2/hold_read_write
add wave -position end  sim:/Wrapper_tb/Dut/m2/din
add wave -position end  sim:/Wrapper_tb/Dut/m2/dout
add wave -position end  sim:/Wrapper_tb/Dut/m2/mem
run -all
quit -sim