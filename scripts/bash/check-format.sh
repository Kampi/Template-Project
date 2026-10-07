#!/bin/bash
#
# check-format.sh - C/C++ code style checker using Artistic Style (AStyle)
#
# Usage:
#   ./scripts/bash/check-format.sh [<directory>...]
#
# Description:
#   Scans the given directories (default: src/ and include/) for all *.c, *.h,
#   *.cpp and *.hpp files and runs AStyle against them using the project style
#   configuration stored in scripts/config/.astyle.cfg. Build directories
#   (.pio, build, managed_components) are skipped.
#
#   If any file would be reformatted the script prints the list of offending
#   files, shows the command needed to fix them, restores the originals via
#   'git checkout .' and exits with code 1.
#
#   If all files are already correctly formatted the script exits with code 0.
#
# Requirements:
#   - astyle must be installed and available on PATH
#   - Script must be run from the repository root
#   - scripts/config/.astyle.cfg must exist

ASTYLE_CONFIG="scripts/config/.astyle.cfg"

astyle --version

if [ $# -gt 0 ]; then
    SOURCE_DIRS=("$@")
else
    SOURCE_DIRS=(src include)
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
        \( -name .pio -o -name build -o -name managed_components \) -prune -o \
        -type f \( -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.hpp" \) -print0
}

if [ -z "$(find_sources | tr -d '\0')" ]; then
    echo "No C/C++ files found to check"
    exit 0
fi

# Run astyle and check if any files would be formatted
find_sources | xargs -0 astyle --options="$ASTYLE_CONFIG"

# Check if any files were modified
if ! git diff --quiet; then
    echo "Code style issues found. The following files need formatting:"
    git diff --name-only
    echo ""
    echo "To fix formatting, run astyle with --options=$ASTYLE_CONFIG on these files"
    git checkout .
    exit 1
else
    echo "All files are properly formatted!"
fi
