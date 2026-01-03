#!/bin/bash
unset LD_LIBRARY_PATH
unset XILINX_VIVADO
unset XILINX_HLS

export PATH=/home/joon/tools/Xilinx/Vivado/2024.1/bin:/usr/bin:/bin
source /home/joon/tools/Xilinx/Vivado/2024.1/settings64.sh

exec bash

