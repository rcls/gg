# vivado -source top.tcl

set tb /home/mirror/trenz_board_files
set_param board.repoPaths $tb

create_project Gogo . -part xc7a100tcsg324-2

set_property BOARD_PART_REPO_PATHS $tb [current_project]

set_property board_part trenz.biz:te0710_02_100_2c:part0:1.0 [current_project]
update_ip_catalog

source Go.tcl
validate_bd_design
regenerate_bd_layout

make_wrapper -files [get_files Go.bd] -top

add_files Gogo.srcs/sources_1/bd/Go/hdl/Go_wrapper.v
add_files -fileset constrs_1 /home/ralph/Gogo/Gogo.xdc

update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 4

# While we waiting for synthesis, open up the hw manager.
#open_hw_manager
#connect_hw_server -url localhost:3121 -allow_non_jtag
#current_hw_target [get_hw_targets */xilinx_tcf/Digilent/251633000000A]
#open_hw_target
#set_property PARAM.FREQUENCY 5000000 [get_hw_targets]
#set a100 [lindex [get_hw_devices xc7a100t_0] 0]
#current_hw_device $a100
#refresh_hw_device $a100
#create_hw_cfgmem -hw_device $a100 [lindex [get_cfgmem_parts {s25fl256sxxxxxx0-spi-x1_x2_x4}] 0]

#set cfgmem [get_property PROGRAM.HW_CFGMEM $a100]
#set_property PROGRAM.ADDRESS_RANGE entire_device $cfgmem
#set_property PROGRAM.FILES [list "../peta/Gogo/images/linux/boot.mcs"] $cfgmem
#set_property PROGRAM.UNUSED_PIN_TERMINATION pull-none $cfgmem
#set_property PROGRAM.BLANK_CHECK  0 $cfgmem
#set_property PROGRAM.ERASE  1 $cfgmem
#set_property PROGRAM.CFG_PROGRAM  1 $cfgmem
#set_property PROGRAM.VERIFY  1 $cfgmem
#set_property PROGRAM.CHECKSUM  0 $cfgmem


wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

write_hw_platform -fixed -force -include_bit -file Go_wrapper.xsa
