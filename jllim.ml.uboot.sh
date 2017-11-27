#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:      
#   Author:       jielong.lin 
#   Email:        493164984@qq.com
#   DateTime:     2017-11-26 00:24:25
#   ModifiedTime: 2017-11-27 00:28:20

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

Uboot URL:
    ftp://ftp.denx.de/pub/u-boot/


EOF


