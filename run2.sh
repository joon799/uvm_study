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


