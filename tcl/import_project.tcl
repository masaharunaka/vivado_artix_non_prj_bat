# Create project
create_project arty_mb arty_mb -part xc7a35ticsg324-1L
set_property board_part digilentinc.com:arty:part0:1.1 [current_project]

# import source file(block design)
source "../../src/mb/bd/arty_mb.tcl"
add_files ../../src/mb/wrapper/arty_mb_wrapper.v

# import source file (verilog/vhdl)
add_files ../../src/verilog/arty_mb_top.v
add_files ../../src/verilog/common/counter.v
add_files ../../src/verilog/io_delay/io_delay_module.v

# import source file (xci)
add_files ../../src/xci/dbg/ila_0.xci

# import library

# import constrs
import_files -force
import_files -fileset constrs_1 -force -norecurse ../../xdc/arty_io.xdc
import_files -fileset constrs_1 -force -norecurse ../../xdc/arty_timing.xdc
