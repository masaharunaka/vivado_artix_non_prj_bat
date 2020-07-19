# Create project
create_project arty_mb arty_mb -part xc7a35ticsg324-1L
set_property board_part digilentinc.com:arty:part0:1.1 [current_project]

# import source file
source "../../src/mb/bd/arty_mb.tcl"

add_files ../../src/mb/wrapper/arty_mb_wrapper.v
add_files ../../src/top/arty_mb_top.v

# import library

# import constrs
import_files -force
import_files -fileset constrs_1 -force -norecurse ../../xdc/arty_io.xdc
import_files -fileset constrs_1 -force -norecurse ../../xdc/arty_timing.xdc
