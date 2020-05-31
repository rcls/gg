# vivado -source top.tcl

open_project Gogo

launch_runs synth_1 -jobs 4
wait_on_run synth_1
