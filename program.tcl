
# While we waiting for synthesis, open up the hw manager.
open_hw_manager
connect_hw_server -url localhost:3121 -allow_non_jtag
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/251633000000A]
open_hw_target
set_property PARAM.FREQUENCY 5000000 [get_hw_targets]
set a100 [lindex [get_hw_devices xc7a100t_0] 0]
current_hw_device $a100
refresh_hw_device $a100

set_property PROGRAM.FILE download.bit $a100

program_hw_devices $a100

quit
