# Create project
# create_project project_bft_batch ./Tutorial_Created_Data/project_bft_batch -part xc7a200tfbg676-2

create_project arty_mb arty_mb -part xc7a35ticsg324-1L
set_property board_part digilentinc.com:arty:part0:1.1 [current_project]

# import source file
source "../../src/mb/bd/arty_mb.tcl"

add_files ../../src/mb/wrapper/arty_mb_wrapper.v
add_files ../../src/top/arty_mb_top.v

# import library
# set_property library bftLib [get_files  {../../Sources/hdl/bftLib/round_4.vhdl ../../Sources/hdl/bftLib/round_3.vhdl ../../Sources/hdl/bftLib/round_2.vhdl ../../Sources/hdl/bftLib/round_1.vhdl ../../Sources/hdl/bftLib/core_transform.vhdl ../../Sources/hdl/bftLib/bft_package.vhdl}]

# import constrs
import_files -force
#import_files -fileset constrs_1 -force -norecurse ../../xdc/system.xdc
import_files -fileset constrs_1 -force -norecurse ../../xdc/arty_io.xdc
import_files -fileset constrs_1 -force -norecurse ../../xdc/arty_timing.xdc
