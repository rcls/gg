
open_hw_manager
connect_hw_server -url localhost:3121 -allow_non_jtag
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/251633000000A]
open_hw_target
set_property PARAM.FREQUENCY 5000000 [get_hw_targets]
set a100 [lindex [get_hw_devices xc7a100t_0] 0]

current_hw_device $a100
refresh_hw_device $a100
create_hw_cfgmem -hw_device $a100 [lindex [get_cfgmem_parts {s25fl256sxxxxxx0-spi-x1_x2_x4}] 0]

set cfgmem [get_property PROGRAM.HW_CFGMEM $a100]
set_property PROGRAM.ADDRESS_RANGE entire_device $cfgmem
set_property PROGRAM.FILES boot.mcs $cfgmem
set_property PROGRAM.UNUSED_PIN_TERMINATION pull-none $cfgmem
set_property PROGRAM.BLANK_CHECK  0 $cfgmem
set_property PROGRAM.ERASE  1 $cfgmem
set_property PROGRAM.CFG_PROGRAM  1 $cfgmem
set_property PROGRAM.VERIFY  1 $cfgmem
set_property PROGRAM.CHECKSUM  0 $cfgmem

create_hw_bitstream -hw_device $a100 [get_property PROGRAM.HW_CFGMEM_BITFILE $a100]
program_hw_devices $a100
refresh_hw_device $a100

program_hw_cfgmem $cfgmem
#refresh_hw_device $a100

boot_hw_device $a100
