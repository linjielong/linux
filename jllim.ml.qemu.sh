#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:
#   Author:       jielong.lin 
#   Email:        493164984@qq.com
#   DateTime:     2017-11-26 00:25:47
#   ModifiedTime: 2017-11-26 22:49:46

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bgreen}${Fwhite}===========================================${AC}
${Bgreen}${Fwhite}  Qemu For uboot linux with device-tree    ${AC}
${Bgreen}${Fwhite}-------------------------------------------${AC}

https://www.qemu.org/download/

${Fgreen}Build instructions${AC}

${Fseablue}To download and build QEMU 2.11.0-rc2:${AC}

wget https://download.qemu.org/qemu-2.11.0-rc2.tar.xz
tar xvJf qemu-2.11.0-rc2.tar.xz
cd qemu-2.11.0-rc2
./configure
make

${Fseablue}To download and build QEMU from git:${AC}

git clone git://git.qemu.org/qemu.git
cd qemu
git submodule init
git submodule update --recursive
./configure
make



${Fred}/opt/FriendlyARM/toolschain/4.4.3/bin/arm-linux-gcc: 15: exec: /opt/FriendlyARM/toolschain/4.4.3/bin/.arm-none-linux-gnueabi-gcc: not found${AC}
${Fgreen}The ia32-libs should be installed for 64bit debian or ubuntu${AC}
FOR 64bit debian:
  apt-get install lib32z1 lib32ncurses5




EOF

