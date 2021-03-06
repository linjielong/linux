#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:
#   Author:       jielong.lin 
#   Email:        493164984@qq.com
#   DateTime:     2017-11-26 00:25:47
#   ModifiedTime: 2017-11-27 21:18:23

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

${Fred}/opt/FriendlyARM/toolschain/4.4.3/libexec/gcc/arm-none-linux-gnueabi/4.4.3/cc1: error while loading shared libraries: libstdc++.so.6: cannot open shared object file: No such file or directory
Makefile:439: recipe for target 'include/autoconf.mk' failed${AC}
aptitude install lib32stdc++6

${Fred}/usr/bin/ld: vl.o: undefined reference to symbol 'timer_settime@@GLIBC_2.3.3'
//lib/x86_64-linux-gnu/librt.so.1: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status${AC}
vim /home/root/Desktop/qemu_for_uboot_linux/run_qemu_mini2440/qemu_mini2440/mini2440/configure
...
1244 
1245 ##########################################
1246 # Do we need librt
1247 CLOCKLIBS=""
1248 cat > \$TMPC <<EOF
1249 #include <signal.h>
1250 #include <time.h>
1251 ${Fyellow}//int main(void) { clockid_t id; return clock_gettime(id, NULL); }${AC}
1252 ${Fyellow}int main(void) { struct itimerspec v; timer_t t; return timer_gettime (t, &v); } ${AC}
1253 EOF
1254 
1255 rt=no



EOF

