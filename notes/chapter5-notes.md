# Chapter 5 Notes — Compiling a Cross-Toolchain

## 1 SBU = 51 seconds on this machine (Lenovo LOQ, 16 cores)

## What This Chapter Built
A cross-toolchain — tools that run on Ubuntu but produce code FOR Glitchix.
All tools installed in $LFS/tools/ (temporary, not part of final system)

## Packages Built (in order)

### 1. Binutils 2.46.0 Pass 1 ✅
- First package = SBU baseline (51 seconds)
- Built cross assembler (as) and cross linker (ld)
- Must be first — GCC and Glibc test for it during their configure

### 2. GCC 15.2.0 Pass 1 ✅
- The cross-compiler itself
- Deliberately crippled — no threads, no shared libs, no libstdc++
- Reason: those features need Glibc which didn't exist yet
- GMP, MPFR, MPC bundled inside GCC source before building
- Created limits.h header after install

### 3. Linux API Headers 6.18.10 ✅
- Stable "contract" between kernel and userspace programs
- Glibc needs these to know what the kernel provides
- Sanitized with make mrproper + make headers
- Copied to $LFS/usr/include

### 4. Glibc 2.43 ✅
- Most important package — every program depends on it
- Cross-compiled FOR Glitchix using our new cross-compiler
- Applied glibc-fhs-1.patch for standard filesystem paths
- DESTDIR=$LFS ensures it installs into Glitchix, not Ubuntu
- All sanity checks passed ✅

### 5. Libstdc++ from GCC 15.2.0 ✅
- C++ standard library
- Couldn't build earlier — needed Glibc first
- Re-extracted GCC source, only built libstdc++-v3 component
- Removed .la files (harmful for cross-compilation)

## Key Concepts Learned
- Cross-compilation: build on Ubuntu, produce code for Glitchix
- LFS_TGT=x86_64-lfs-linux-gnu tricks build system into cross mode
- DESTDIR=$LFS = install into Glitchix partition not Ubuntu
- Build order matters: Binutils → GCC → Headers → Glibc → Libstdc++
- $LFS/tools/ is temporary — deleted after Chapter 6

## Sanity Check Results (after Glibc)
- Dynamic linker: /lib64/ld-linux-x86-64.so.2 ✅
- Start files: Scrt1.o, crti.o, crtn.o from /mnt/lfs ✅
- Header search includes /mnt/lfs/usr/include ✅
- libc.so.6 found at /mnt/lfs/usr/lib ✅
- ld-linux-x86-64.so.2 found at /mnt/lfs/usr/lib ✅