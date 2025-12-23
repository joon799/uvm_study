source /home/joon/uvm_study/tools/2025.2/Vivado/settings64.sh
//vivado install and in to .bashrc to setting.sh 
//
//simulation in terminal
//sudo apt update, sudo apt install gtkwave
//gtkwave wave.vcd
//
xvlog -sv counter.sv
xvlog -sv test.sv
xelab test -s sim
xsim sim --runall

gtkwave wave.vcd

chmod +x run.sh //
./run1.sh

sudo dpkg --add-architecture i386
sudo apt update

sudo apt install libc6-dev-i386

sudo apt install lib32gcc-s1 lib32stdc++6


sudo snap install gitkraken --classic
sd
//in bashrc
//

source /home/joon/uvm_study/tools/DocNav/.settings64-DocNav.sh
source /home/joon/uvm_study/tools/2025.2/Vivado/.settings64-Vivado.sh
source /home/joon/uvm_study/tools/2025.2/Model_Composer/.settings64-Model_Composer.sh
source /home/joon/uvm_study/tools/2025.2/Vitis/.settings64-Vitis_for_HLS.sh

export PATH=$PATH:/home/joon/uvm_study/tools/2025.2/bin/xvlog

#!/bin/bash
set -e
source /home/joon/uvm_study/tools/2025.2/Vivado/settings64.sh

UVM_HOME="/home/joon/uvm_study/tools/2025.2/data/system_verilog/uvm_1.2"

# include 
INCLUDE_TB="./tb"
#DPI_C="./dpi_stub.c"
#DPI_LIB="./dpi_stub.so"

echo "=== Compiling RTL ==="
xvlog -sv \
  -i $INCLUDE_TB \
  ./RTL/counter.sv \
  -L uvm \
  || exit 1


echo "=== Compiling UVM testbench ==="
xvlog -sv \
  -i $INCLUDE_TB \
  ./tb/top.sv \
  -L uvm \
  || exit 1
 # $UVM_HOME/xlnx_uvm_package.sv \
echo "=== Compiling DPI-C stub ==="
#gcc -fPIC -shared -o $DPI_LIB $DPI_C || exit 1
#gcc -fPIC -shared dpi_stub.c \
#  -I/home/joon/uvm_study/tools/2025.2/data/xsim/include \
#  -o dpi_stub.so
echo "=== Elaborating ==="
xelab top -s sim \
  -timescale 1ns/1ps \
  -debug off \
  -L uvm \
  || exit 1

echo "=== Running Simulation ==="
xsim sim --runall  || exit 1
#--runall
echo "=== Done ==="
