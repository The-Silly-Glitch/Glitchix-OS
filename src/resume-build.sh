#!/bin/bash
# Run this after every reboot before continuing LFS build
# Usage: sudo bash scripts/resume-build.sh

set -e

export LFS=/mnt/lfs

echo "=== Glitchix OS Build Resume Script ==="

# Check if already mounted
if mount | grep -q "$LFS"; then
    echo "✓ $LFS already mounted"
else
    echo "Mounting Glitchix partition..."
    mount -v -t ext4 /dev/nvme0n1p7 $LFS
    echo "✓ Mounted $LFS"
fi

# Enable swap
if swapon --show | grep -q nvme0n1p8; then
    echo "✓ Swap already active"
else
    echo "Enabling swap..."
    swapon -v /dev/nvme0n1p8
    echo "✓ Swap enabled"
fi

echo ""
echo "=== Environment Status ==="
echo "LFS        = $LFS"
mount | grep lfs
free -h | grep Swap

echo ""
echo "=== Ready! Now run: su - lfs ==="