#!/bin/bash

set -x

source /home/Xilinx/Vivado/2019.2/.settings64-Vivado.sh
source /home/peta/settings.sh

set -e -x

mkdir -p p
cd p

petalinux-create -t project -n Gogo --template microblaze --force
cd Gogo

cp -r ../../peta-base/* .

export MAKEFLAGS=-j8

petalinux-config --get-hw-description ../.. --silentconfig
petalinux-config --silentconfig
petalinux-build

petalinux-package --boot --format MCS --fpga images/linux/system.bit --dtb ./images/linux/system.dtb --u-boot ./images/linux/u-boot-s.bin --flash-intf SPIx4 --flash-size 32 --kernel images/linux/image.ub  --force
