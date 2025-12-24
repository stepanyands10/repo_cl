#!/bin/bash

# 1 = print actions only, 0 = actually move files
DRY_RUN=1

# Skip hidden files (1 = skip, 0 = include)
SKIP_HIDDEN=1

#Skip files
EXCLUDE_NAMES=("module" "system_file")

#Destination folders
IMG_DIR="images"
DOC_DIR="docs"
SHELL_DIR="scripts"
OTHER_DIR="other"

#Extension lists
IMG_EXTS=("jpg" "jpeg" "png" "bmp" "JPG" "JPEG" "PNG" "BMP")
DOC_EXTS=("txt" "md")
SHELL_EXTS=("sh")
#