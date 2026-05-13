#!/bin/sh

# # Collect AUR cache dirs
# yaycache="$(find "$HOME"/.cache/yay -maxdepth 1 -type d | awk '{ print "-c " $1 }' | tail -n +2)"
# echo "==> Keep last 2 installed versions"
# /usr/bin/paccache -dvk2 -c /var/cache/pacman/pkg $yaycache
#
#
#
set -e

echo "====================================="
echo "   Pacman + AUR Cache Cleanup Tool   "
echo "====================================="

AUR_CACHE_DIR="$HOME/.cache/yay"

echo
echo "== Disk usage BEFORE cleanup =="
du -sh /var/cache/pacman/pkg 2>/dev/null || true
du -sh "$AUR_CACHE_DIR" 2>/dev/null || true

echo
echo "== Collecting AUR cache directories =="

AUR_CACHE_ARGS=$(find "$AUR_CACHE_DIR" -mindepth 1 -maxdepth 1 -type d -printf "-c %p ")

echo
echo "== Checking for UNINSTALLED AUR packages (preview only) =="

AUR_ORPHANED=$(
  /usr/bin/paccache -duvvk0 $AUR_CACHE_ARGS |
    grep "$AUR_CACHE_DIR" |
    cut -d \' -f2 |
    rev | cut -d / -f2- | rev
)

if [ -n "$AUR_ORPHANED" ]; then
  echo
  echo "Orphaned AUR build directories:"
  printf '%s\n' $AUR_ORPHANED

  echo
  echo "Removing orphaned AUR build directories..."
  rm -rvf $AUR_ORPHANED
else
  echo "No orphaned AUR build directories found."
fi

echo
echo "== Cleaning UNINSTALLED repo packages (keep 1 version) =="
/usr/bin/paccache -rvuk1

echo
echo "== Cleaning INSTALLED packages (keep 2 versions) =="
/usr/bin/paccache -rvk2 -c /var/cache/pacman/pkg $AUR_CACHE_ARGS

echo
echo "== Disk usage AFTER cleanup =="
du -sh /var/cache/pacman/pkg 2>/dev/null || true
du -sh "$AUR_CACHE_DIR" 2>/dev/null || true

echo
echo "Cleanup complete."
