#!/bin/bash
set -e
source /home/joon/tools/Xilinx/Vivado/2024.1/settings64.sh
export PATH=$PATH:/home/joon/tools/Xilinx/Vivado/2024.1/bin/xvlog
UVM_HOME="/home/joon/tools/Xilinx/Vivado/2024.1/data/system_verilog/uvm_1.2"


# include 
#INCLUDE_TB="./tb_sram_with_axi"

#echo "=== Compiling RTL ==="
#xvlog -sv \
#  -i $INCLUDE_TB \
#  ./RTL_sram_with_axi/sram_axi_lite.sv \
#  -L uvm \
#  || exit 1
xvlog -sv -f sram_with_axi_file.f -L uvm

xelab top -s sim -L uvm
xsim sim --runall
gtkwave wave.vcd

