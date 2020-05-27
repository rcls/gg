
create_project Gogo . -part xc7a100tcsg324-2
set_property board_part trenz.biz:te0710_02_100_2c:part0:1.0 [current_project]
update_ip_catalog

source Go.tcl
validate_bd_design
regenerate_bd_layout

make_wrapper -files [get_files Go.bd] -top
add_files -fileset constrs_1 -norecurse /home/ralph/Gogo/Gogo.xdc

launch_runs impl_1 synth_1
