# vivado -source top.tcl

open_project Gogo

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
write_hw_platform -fixed -force -include_bit -file Go_wrapper.xsa
