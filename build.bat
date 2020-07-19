@echo off
set dt=%date%
set tm=%time: =0%
set FName=%dt:~-10,4%%dt:~-5,2%%dt:~-2,2%_%tm:~-11,2%%tm:~-8,2%

mkdir build
cd build
mkdir %FName%
cd %FName%

xcopy ..\..\tcl tcl /D /S /R /Y /I /K

C:\Xilinx\Vivado\2018.1\bin\vivado.bat -mode tcl -source tcl/do_build.tcl
