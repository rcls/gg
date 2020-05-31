open_project Gogo
open_bd_design Gogo.srcs/sources_1/bd/Go/Go.bd
validate_bd_design
write_bd_tcl -force Go.tcl
