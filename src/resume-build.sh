#!/bin/bash
# Run as root after every reboot before continuing LFS build
# Usage: sudo bash scripts/resume-build.sh

set -e
export LFS=/mnt/lfs

echo "=== Glitchix OS Build Resume Script ==="

# Check/mount main partition
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
    swapon -v /dev/nvme0n1p8
    echo "✓ Swap enabled"
fi

# Mount virtual filesystems
echo "Mounting virtual filesystems..."
mount -v --bind /dev $LFS/dev
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
    install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
    mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi

echo "✓ Virtual filesystems mounted"
echo ""
echo "=== Status ==="
mount | grep lfs
free -h | grep Swap
echo ""
echo "=== Ready! Now run: ==="
echo 'chroot "$LFS" /usr/bin/env -i \'
echo '    HOME=/root \'
echo '    TERM="$TERM" \'
echo "    PS1='(lfs chroot) \u:\w\$ ' \\"
echo '    PATH=/usr/bin:/usr/sbin \'
echo '    MAKEFLAGS="-j$(nproc)" \'
echo '    TESTSUITEFLAGS="-j$(nproc)" \'
echo '    /bin/bash --login'