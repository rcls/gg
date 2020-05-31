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
add_files -fileset constrs_1 Gogo.xdc
