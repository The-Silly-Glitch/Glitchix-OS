# Glitchix OS 🐧
A custom Linux distribution built from scratch following the Linux From Scratch (LFS) v13.0-systemd book.

## Build Environment
- Host OS: Ubuntu 24.04 (dual boot)
- LFS Version: 13.0-systemd
- Target Partition: /dev/nvme0n1p7 (45GB)
- Mount Point: /mnt/lfs

## Progress
- [x] Chapter 1 — Introduction
- [x] Chapter 2 — Preparing the Host System
- [x] Chapter 3 — Packages and Patches
- [x] Chapter 4 — Final Preparations
- [x] Chapter 5 — Compiling a Cross-Toolchain
- [x] Chapter 6 — Cross Compiling Temporary Tools
- [x] Chapter 7 — Entering Chroot and Building Additional Tools
- [ ] Chapter 8 — Installing Basic System Software
- [ ] Chapter 9 — System Configuration
- [ ] Chapter 10 — Making the LFS System Bootable
- [ ] Chapter 11 — The End

## Partition Layout
| Partition | Size | Purpose |
|---|---|---|
| nvme0n1p7 | 45GB | Glitchix root (ext4, mounted at /mnt/lfs) |
| nvme0n1p8 | 5GB | Swap |

## How to Resume After Reboot
```bash
export LFS=/mnt/lfs
umask 022
sudo mount -v -t ext4 /dev/nvme0n1p7 $LFS
sudo swapon -v /dev/nvme0n1p8
```