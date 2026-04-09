# Chapter 2 Notes — Preparing the Host System

## Host System Checks
- Ran version-check.sh — most tools OK
- Fixed missing: bison, gawk, texinfo
- Fixed: sh was pointing to dash, changed to bash
- All checks passed after fixes

## Partition Setup
- Used GParted from live USB to shrink Ubuntu (nvme0n1p6)
- Created nvme0n1p7 (45GB, ext4) — Glitchix root
- Created nvme0n1p8 (5GB) — swap
- Formatted swap with mkswap
- Mounted Glitchix at /mnt/lfs
- Added both partitions to /etc/fstab

## Key Commands Used
```bash
sudo mkswap /dev/nvme0n1p8
sudo mkdir -pv $LFS
sudo mount -v -t ext4 /dev/nvme0n1p7 $LFS
sudo chown root:root $LFS
sudo chmod 755 $LFS
sudo swapon -v /dev/nvme0n1p8
```

## Lessons Learned
- A partition is raw space; a filesystem (ext4) gives it structure
- Mounting = attaching a partition to a folder so the OS can use it
- $LFS variable saves typing /mnt/lfs hundreds of times
- umask 022 ensures safe default file permissions during build