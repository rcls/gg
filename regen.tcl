# vivado -source regen.tcl

launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
write_bd_tcl -force /home/ralph/Gogo/Go.tcl
write_hw_platform -fixed -force -include_bit -file Go_wrapper.xsa
