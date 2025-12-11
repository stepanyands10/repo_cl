#!/bin/bash

if [ ! -f "./config.sh" ] || [ ! -f "./rules.sh" ]; then
	echo "Missing config.sh or rules.sh"
	exit 1
fi

source ./config.sh
source ./rules.sh

if [ $"DRY_RUN" -eq 1 ]; then
	echo "[dry-run] $IMG_DIR will be created"
	echo "[dry-run] $DOC_DIR will be created"
	echo "[dry-run] $SHELL_DIR will be created"
	echo "[dry-run] $OTHER_DIR will be created"
else
	mkdir -p "./$IMG_DIR" "./$DOC_DIR" "./$SHELL_DIR" "./$OTHER_DIR"
fi

for fmt in ${IMG_EXTS[*]}
do
	files=$(ls - m *.${fmt} 2>/dev/null )
	if [[ ! -z ${files} ]]; then
		if [ "$DRY_RUN" -eq 1 ]; then
			echo "[dry-run] ${files} files will be removed to image directory"
		else
			echo "moving..."
		fi
	fi
done

