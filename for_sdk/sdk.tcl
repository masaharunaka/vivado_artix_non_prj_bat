# xsct commands
setws ./arty_mb/arty_mb.sdk
createhw -name hw0 -hwspec ./arty_mb/arty_mb.sdk/arty_mb_top.hdf
createbsp -name bsp0 -hwproject hw0 -proc microblaze_0 -os standalone

createapp -name hello -app {Hello World} -proc microblaze_0 -hwproject hw0 -os standalone
#configbsp -bsp hello_bsp stdin mdm_0
#configbsp -bsp hello_bsp stdout mdm_0
#updatemss -mss hello_bsp/system.mss
#regenbsp -bsp hello_bsp
projects -build

