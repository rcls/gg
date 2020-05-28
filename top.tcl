# vivado -source top.tcl

create_project Gogo . -part xc7a100tcsg324-2
set_property board_part trenz.biz:te0710_02_100_2c:part0:1.0 [current_project]
update_ip_catalog

source Go.tcl
validate_bd_design
regenerate_bd_layout

make_wrapper -files [get_files Go.bd] -top

add_files -norecurse Gogo.srcs/sources_1/bd/Go/hdl/Go_wrapper.v
add_files -fileset constrs_1 -norecurse /home/ralph/Gogo/Gogo.xdc

update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

write_hw_platform -fixed -force -include_bit -file Go_wrapper.xsa


#generate_target all [get_files Gogo.srcs/sources_1/bd/Go/Go.bd]
#
#catch { config_ip_cache -export [get_ips -all Go_mig_7series_0_0] }
#catch { config_ip_cache -export [get_ips -all Go_smartconnect_0_0] }
#catch { config_ip_cache -export [get_ips -all Go_smartconnect_1_0] }

#export_ip_user_files
#create_ip_run [get_files -of_objects [get_fileset sources_1] /home/ralph/Gogo/Gogo.srcs/sources_1/bd/Go/Go.bd]

#launch_runs impl_1 synth_1 -jobs 8

#synth_design
#opt_design, power_opt_design, place_design, route_design, phys_opt_design,
#and write_bitstream
#launch_runs impl_1 -to_step write_bitstream -jobs 8
#write_hw_platform -fixed -force  -include_bit -file /home/ralph/Gogo/Go_wrapper.xsa

