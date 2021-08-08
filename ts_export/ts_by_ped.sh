#!/usr/bin/env bash

# personal script of Ped to put all ODN files into card image, run CSpect and extract ASM versions
MMC=${MMC:-~/zx/core/mmc-1.3.2-128mb/tbblue.mmc}
SRCDIR="odin/memdump"
MMC=$MMC ./tommc.sh "$SRCDIR" && mmcCSpect "$MMC"
MMC=$MMC ./frommmc.sh "$SRCDIR"
