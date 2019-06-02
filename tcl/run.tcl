# Mimic GUI behavior of automatically setting top and file compile order
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# Launch Synthesis
launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name netlist_1

# Generate a timing and power reports and write to disk
report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file ./syn_timing.rpt
report_power -file ./syn_power.rpt

# Launch Implementation
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1 

# Generate a timing and power reports and write to disk
# comment out the open_run for batch mode
open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file ./imp_timing.rpt
report_power -file ./imp_power.rpt
# comment out the for batch mode
# start_gui

# end
exit
