set -e
source /home/joon/tools/Xilinx/Vivado/2024.1/settings64.sh

export UVM_HOME="/home/joon/tools/Xilinx/Vivado/2024.1/data/system_verilog/uvm_1.2"

xvlog -sv -f sram_with_axi_file.f -L uvm
xelab top -s sim -L uvm
xsim sim --runall
gtkwave wave.vcd

