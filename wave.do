onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_and/clock_tb
add wave -noupdate /testbench_and/Read_tb
add wave -noupdate /testbench_and/clear_tb
add wave -noupdate /testbench_and/Yin_tb
add wave -noupdate /testbench_and/z_hi_in_tb
add wave -noupdate /testbench_and/z_lo_in_tb
add wave -noupdate /testbench_and/Hiin_tb
add wave -noupdate /testbench_and/Loin_tb
add wave -noupdate /testbench_and/Pcin_tb
add wave -noupdate /testbench_and/IRin_tb
add wave -noupdate /testbench_and/outportin_tb
add wave -noupdate /testbench_and/c_sign_extendedin_tb
add wave -noupdate /testbench_and/strobe_tb
add wave -noupdate /testbench_and/wren_sig_tb
add wave -noupdate /testbench_and/rdem_sig_tb
add wave -noupdate /testbench_and/Rin_tb
add wave -noupdate /testbench_and/Rout_tb
add wave -noupdate /testbench_and/Gra_tb
add wave -noupdate /testbench_and/Grb_tb
add wave -noupdate /testbench_and/Grc_tb
add wave -noupdate /testbench_and/BAout_tb
add wave -noupdate /testbench_and/Cout_tb
add wave -noupdate /testbench_and/hi_out_tb
add wave -noupdate /testbench_and/lo_out_tb
add wave -noupdate /testbench_and/z_hi_out_tb
add wave -noupdate /testbench_and/z_lo_out_tb
add wave -noupdate /testbench_and/PC_out_tb
add wave -noupdate /testbench_and/MDR_out_tb
add wave -noupdate /testbench_and/port_out_tb
add wave -noupdate /testbench_and/MDR_in_tb
add wave -noupdate /testbench_and/MAR_in_tb
add wave -noupdate /testbench_and/Conin_tb
add wave -noupdate /testbench_and/ALUcontrol_signals_tb
add wave -noupdate /testbench_and/MData_in_tb
add wave -noupdate /testbench_and/inport_unit_tb
add wave -noupdate /testbench_and/outport_unit_tb
add wave -noupdate /testbench_and/Present_state
add wave -noupdate /testbench_and/DUT/reg1/clr
add wave -noupdate /testbench_and/DUT/reg1/clk
add wave -noupdate /testbench_and/DUT/reg1/wr
add wave -noupdate -radix hexadecimal /testbench_and/DUT/reg1/inputD
add wave -noupdate -radix hexadecimal /testbench_and/DUT/reg1/outputQ
add wave -noupdate /testbench_and/DUT/PC1/clr
add wave -noupdate /testbench_and/DUT/PC1/clk
add wave -noupdate /testbench_and/DUT/PC1/wr
add wave -noupdate /testbench_and/DUT/PC1/inputD
add wave -noupdate /testbench_and/DUT/PC1/outputQ
add wave -noupdate /testbench_and/DUT/IR1/clr
add wave -noupdate /testbench_and/DUT/IR1/clk
add wave -noupdate /testbench_and/DUT/IR1/wr
add wave -noupdate /testbench_and/DUT/IR1/inputD
add wave -noupdate /testbench_and/DUT/IR1/outputQ
add wave -noupdate /testbench_and/DUT/encoder1/r00_out
add wave -noupdate /testbench_and/DUT/encoder1/r01_out
add wave -noupdate /testbench_and/DUT/encoder1/r02_out
add wave -noupdate /testbench_and/DUT/encoder1/r03_out
add wave -noupdate /testbench_and/DUT/encoder1/r04_out
add wave -noupdate /testbench_and/DUT/encoder1/r05_out
add wave -noupdate /testbench_and/DUT/encoder1/r06_out
add wave -noupdate /testbench_and/DUT/encoder1/r07_out
add wave -noupdate /testbench_and/DUT/encoder1/r08_out
add wave -noupdate /testbench_and/DUT/encoder1/r09_out
add wave -noupdate /testbench_and/DUT/encoder1/r10_out
add wave -noupdate /testbench_and/DUT/encoder1/r11_out
add wave -noupdate /testbench_and/DUT/encoder1/r12_out
add wave -noupdate /testbench_and/DUT/encoder1/r13_out
add wave -noupdate /testbench_and/DUT/encoder1/r14_out
add wave -noupdate /testbench_and/DUT/encoder1/r15_out
add wave -noupdate /testbench_and/DUT/encoder1/hi_out
add wave -noupdate /testbench_and/DUT/encoder1/lo_out
add wave -noupdate /testbench_and/DUT/encoder1/z_hi_out
add wave -noupdate /testbench_and/DUT/encoder1/z_lo_out
add wave -noupdate /testbench_and/DUT/encoder1/PC_out
add wave -noupdate /testbench_and/DUT/encoder1/MDR_out
add wave -noupdate /testbench_and/DUT/encoder1/port_out
add wave -noupdate /testbench_and/DUT/encoder1/c_out
add wave -noupdate /testbench_and/DUT/encoder1/s_out
add wave -noupdate -radix hexadecimal /testbench_and/DUT/busMux1/BusMuxOut
add wave -noupdate /testbench_and/DUT/MAR1/clr
add wave -noupdate /testbench_and/DUT/MAR1/clk
add wave -noupdate /testbench_and/DUT/MAR1/wr
add wave -noupdate -radix hexadecimal /testbench_and/DUT/MAR1/inputD
add wave -noupdate -radix hexadecimal /testbench_and/DUT/MAR1/outputQ
add wave -noupdate /testbench_and/DUT/MAR1/x
add wave -noupdate /testbench_and/DUT/MDR1/busMuxOut
add wave -noupdate -radix hexadecimal /testbench_and/DUT/MDR1/MDataIn
add wave -noupdate /testbench_and/DUT/MDR1/clr
add wave -noupdate /testbench_and/DUT/MDR1/clk
add wave -noupdate /testbench_and/DUT/MDR1/mdr_in
add wave -noupdate /testbench_and/DUT/MDR1/MDRread
add wave -noupdate -radix hexadecimal /testbench_and/DUT/MDR1/outputQ
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {364922 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 256
configure wave -valuecolwidth 361
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {525 ns}
