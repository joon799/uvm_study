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

