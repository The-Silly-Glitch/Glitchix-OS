# Chapter 3 Notes — Packages and Patches

## What This Chapter Does
Downloads all source code packages and patches that will become Glitchix OS.
Think of it as gathering all ingredients before cooking.

## Storage Location
All packages stored at: $LFS/sources (/mnt/lfs/sources)
- Writable and sticky (chmod a+wt) — only owner can delete files

## Download Method
Used wget-list from LFS stable-systemd mirror:
```bash
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

# Download the package list
wget https://www.linuxfromscratch.org/lfs/downloads/stable-systemd/wget-list \
     --directory-prefix=$LFS/sources

# Download checksums
wget https://www.linuxfromscratch.org/lfs/downloads/stable-systemd/md5sums \
     --directory-prefix=$LFS/sources

# Download all packages at once
wget --input-file=$LFS/sources/wget-list \
     --continue \
     --directory-prefix=$LFS/sources
```

## Verification
```bash
pushd $LFS/sources
md5sum -c md5sums
popd
```
All 84 packages and 5 patches verified OK.

## Fix Needed
The wget-list URL in the book (13.0-systemd) returned 404.
Correct URL uses "stable-systemd" instead of "13.0-systemd".
Also the file is called "wget-list" not "wget-list-systemd".

## Packages Highlights
| Package | Version | Purpose |
|---|---|---|
| Linux | 6.18.10 | The kernel — heart of Glitchix |
| Glibc | 2.43 | C standard library |
| GCC | 15.2.0 | The compiler |
| Bash | 5.3 | The shell |
| Systemd | 259.1 | Init system |
| GRUB | 2.14 | Bootloader |
| Vim | 9.2.0078 | Text editor |

## Patches Applied
| Patch | Purpose |
|---|---|
| bzip2-install_docs | Fixes docs not installing correctly |
| coreutils-i18n | Fixes international character handling |
| expect-gcc15 | Makes expect compile with GCC 15 |
| glibc-fhs | Makes Glibc follow filesystem standard |
| kbd-backspace | Fixes backspace/delete key behavior |

## Total Size
~603 MB packages + ~156 KB patches