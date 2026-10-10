#!/bin/bash
#
# check-clang-format.sh - C/C++ code style checker for Zephyr / West based firmware using clang-format
#
# Usage:
#   ./scripts/bash/check-clang-format.sh [<directory>...]
#
# Description:
#   Scans the given directories (default: firmware/) for all *.c, *.h, *.cpp and
#   *.hpp files and checks them with clang-format against the project style
#   stored in scripts/config/.clang-format (Zephyr rules with 4 spaces).
#   Build directories (build, twister-out) and West modules (modules, zephyr,
#   bootloader, tools) are skipped.
#
#   The files are not modified. If a file would be reformatted the script prints
#   the differences and the command needed to fix them and exits with code 1.
#
#   If all files are already correctly formatted the script exits with code 0.
#
# Requirements:
#   - clang-format 16 or later must be installed and available on PATH
#   - Script must be run from the repository root
#   - scripts/config/.clang-format must exist

CLANG_FORMAT_CONFIG="scripts/config/.clang-format"

clang-format --version || exit 1

if [ ! -f "$CLANG_FORMAT_CONFIG" ]; then
    echo "$CLANG_FORMAT_CONFIG not found"
    exit 1
fi

if [ $# -gt 0 ]; then
    SOURCE_DIRS=("$@")
else
    SOURCE_DIRS=(firmware)
fi

# Only existing directories, 'find' fails on missing ones
EXISTING_DIRS=()
for dir in "${SOURCE_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        EXISTING_DIRS+=("$dir")
    fi
done

if [ ${#EXISTING_DIRS[@]} -eq 0 ]; then
    echo "No source directories found (${SOURCE_DIRS[*]})"
    exit 0
fi

# Find all C/C++ files
find_sources() {
    find "${EXISTING_DIRS[@]}" \
        \( -name build -o -name twister-out -o -name modules -o -name zephyr -o -name bootloader -o -name tools \) -prune -o \
        -type f \( -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.hpp" \) -print0
}

if [ -z "$(find_sources | tr -d '\0')" ]; then
    echo "No C/C++ files found to check"
    exit 0
fi

# --dry-run reports the differences without changing the files
if ! find_sources | xargs -0 clang-format --style="file:$CLANG_FORMAT_CONFIG" --dry-run --Werror; then
    echo ""
    echo "Code style issues found."
    echo "To fix formatting, run clang-format -i --style=file:$CLANG_FORMAT_CONFIG on these files"
    exit 1
else
    echo "All files are properly formatted!"
fi
