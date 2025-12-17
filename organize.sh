#!/bin/bash

if [ ! -f "./config.sh" ] || [ ! -f "./rules.sh" ]; then
	echo "Missing config.sh or rules.sh"
	exit 1
fi

source ./config.sh
source ./rules.sh

if [ "$DRY_RUN" -eq 1 ]; then
	echo "[dry-run] $IMG_DIR will be created"
	echo "[dry-run] $DOC_DIR will be created"
	echo "[dry-run] $SHELL_DIR will be created"
	echo "[dry-run] $OTHER_DIR will be created"
else
	mkdir -p "./$IMG_DIR" "./$DOC_DIR" "./$SHELL_DIR" "./$OTHER_DIR"
fi

is_excluded() {
    local name="$1"

    for ex in "${EXCLUDE_NAMES[@]}"; do
        [[ "$name" == "$ex" ]] && return 0
    done

    return 1
}

has_ext() {
    local file="$1"
    shift

    local ext="${file##*.}"

    for e in "$@"; do
        [[ "$ext" == "$e" ]] && return 0
    done

    return 1
}

apply_rules() {
    local name="$1"

    if [[ "$TO_LOWERCASE" -eq 1 ]]; then
        echo "$name" | tr 'A-Z' 'a-z'
    else
        echo "$name"
    fi
}

for file in *; do
    [[ -d "$file" ]] && continue

    if [[ "$SKIP_HIDDEN" -eq 1 && "$file" == .* ]]; then
        continue
    fi

    if is_excluded "$file"; then
        continue
    fi

    newname="$(apply_rules "$file")"

    if has_ext "$file" "${IMG_EXTS[@]}"; then
        target="$IMG_DIR"
    elif has_ext "$file" "${DOC_EXTS[@]}"; then
        target="$DOC_DIR"
    elif has_ext "$file" "${SHELL_EXTS[@]}"; then
        target="$SHELL_DIR"
    else
        target="$OTHER_DIR"
    fi

    if [[ "$DRY_RUN" -eq 1 ]]; then
        echo "[dry-run] $file → $target/$newname"
    else
        mv "$file" "$target/$newname"
        echo "[moved] $file → $target/$newname"
    fi
done
