#!/bin/bash
set -e
source /home/joon/tools/Xilinx/Vivado/2024.1/settings64.sh

echo "=== Compile ==="
xvlog -sv -L uvm -f file.f

echo "=== Elaborate ==="
xelab top_tb -L uvm -L axi_vip_v1_1_13 -s sim

echo "=== Run Simulation ==="
xsim sim --runall

echo "=== Open GTKWave ==="
gtkwave wave.vcd &

