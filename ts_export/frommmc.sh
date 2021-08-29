#!/usr/bin/env bash

# check for -h or --help as first argument
if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "Usage: frommmc.sh [<source_dir_in_mmc_image>]"
    echo "The card image file is taken from variable MMC, default source directory is 'odin/memdump'"
    exit
fi

# check if MMC variable is defined and points to valid image file
hdfmonkey ls "$MMC" > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && { echo "define variable MMC with image file, like: MMC=~/zx/zxnext.img ./frommmc.sh"; exit 1; }

# check if non-default directory for MEMDUMP was provided, or set default to 'odin/memdump'
[[ -n $1 ]] && SRCDIR="$1" || SRCDIR="odin/memdump"

# check if the directory does exist in the image
hdfmonkey ls "$MMC" "$SRCDIR" > /dev/null || { echo "Source directory '$SRCDIR' doesn't exist in the image"; exit 2; }

# get all MEMDUMP files converted to ASM from MMC image
echo "Getting text/asm files from '$MMC', directory '$SRCDIR':"
PADDING="@                                       @"
for f in ../src/*.odn; do
    ASM_FILE=${f##../src/}
    ASM_FILE="${ASM_FILE/%.odn/.asm}"
    CARD_FILE="$SRCDIR/$ASM_FILE"
    CARD_FILE_STRLEN=${#CARD_FILE}
    echo -e " | $CARD_FILE ${PADDING:CARD_FILE_STRLEN:-1} (original ${f##../})"
    hdfmonkey get "$MMC" "$CARD_FILE" > "$ASM_FILE" || { echo " (ERROR)"; exit 3; }
done
echo "(all OK)"
