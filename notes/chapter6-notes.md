# Chapter 6 Notes — Cross Compiling Temporary Tools

## What This Chapter Does
Uses the cross-toolchain from Chapter 5 to build basic utilities
that will live in Glitchix's final locations ($LFS/usr/).
Still running on Ubuntu — can't use these tools yet until chroot.

## Key Difference from Chapter 5
- Chapter 5 → installed into $LFS/tools/ (temporary)
- Chapter 6 → installed into $LFS/usr/ (final Glitchix locations)

## Packages Built (in order)

### Simple Utilities (all follow standard pattern)
| Package | Command | Purpose |
|---|---|---|
| M4 1.4.21 | m4 | Macro processor for autoconf |
| Ncurses 6.6 | libncurses | Terminal screen handling |
| Bash 5.3 | bash, sh | The shell itself |
| Coreutils 9.10 | ls, cp, mv, rm... | Essential OS commands |
| Diffutils 3.12 | diff | File comparison |
| File 5.46 | file | File type detection |
| Findutils 4.10.0 | find, xargs | File searching |
| Gawk 5.3.2 | awk | Text processing |
| Grep 3.12 | grep | Content searching |
| Gzip 1.14 | gzip, gunzip | File compression |
| Make 4.4.1 | make | Build automation |
| Patch 2.8 | patch | Apply patch files |
| Sed 4.9 | sed | Stream editor |
| Tar 1.35 | tar | Archive tool |
| Xz 5.8.2 | xz | Better compression |

### Big Packages

#### Binutils 2.46.0 Pass 2 ✅
- Full-featured version with shared libraries
- Pass 1 was static only, Pass 2 adds --enable-shared
- Fixed ltmain.sh to prevent linking against host libraries
- Removed harmful .a and .la files after install

#### GCC 15.2.0 Pass 2 ✅ (~4 minutes)
- Full compiler — now with POSIX threads and C++ exceptions
- Last cross-compiled package in the book
- Key additions vs Pass 1:
  - Thread support enabled (gthr-posix.h)
  - libstdc++ fully functional
  - --with-build-sysroot=$LFS ensures correct file lookup
- Created cc symlink → gcc (many scripts use cc)

## Special Build Notes
- Ncurses: built host tic first, then cross-compiled
- File: built host version first to generate signature db
- Coreutils: moved chroot to /usr/sbin after install
- GCC Pass 2: bundled GMP, MPFR, MPC same as Pass 1

## Verification
All tools confirmed present in $LFS/usr/bin:
awk, cc, grep, gzip, make, patch, sed, tar, xz ✅
GCC installed: gcc, gcc-ar, gcc-nm, gcc-ranlib ✅
Cross GCC: x86_64-lfs-linux-gnu-gcc ✅

## What's Next
Chapter 7 — Enter chroot and step INSIDE Glitchix for the first time!