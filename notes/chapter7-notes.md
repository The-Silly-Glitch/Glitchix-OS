# Chapter 7 Notes — Entering Chroot and Building Additional Tools

## The Big Milestone
This chapter is where we stepped INSIDE Glitchix for the first time!
After entering chroot, Ubuntu is only providing the kernel.
Everything else runs from /mnt/lfs.

## Section 7.2 — Ownership Change
Changed all $LFS/* ownership from lfs user to root:
- lfs user only exists on Ubuntu, not inside Glitchix
- chown --from lfs ensures only lfs-owned files are changed

## Section 7.3 — Virtual Kernel Filesystems
Mounted before entering chroot - programs need these to talk to kernel:
| Filesystem | Mount point | Purpose |
|---|---|---|
| devtmpfs (bind) | /dev | Device files |
| devpts | /dev/pts | Pseudo-terminals |
| proc | /proc | Process/kernel info |
| sysfs | /sys | Hardware info |
| tmpfs | /run | Runtime data |

## Section 7.4 — Entering Chroot
The moment Glitchix became real:
```bash
chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j$(nproc)" \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login
```
- Prompt showed: (lfs chroot) I have no name!:/# 
- "I have no name!" is normal - /etc/passwd didn't exist yet

## Section 7.5 — Directory Structure
Created full Linux FHS directory hierarchy:
- /boot, /home, /opt, /srv, /media
- /var/log, /var/cache, /var/spool
- /tmp and /var/tmp with sticky bit (1777)
- /root with restricted permissions (0750)

## Section 7.6 — Essential Files Created
- /etc/mtab → symlink to /proc/self/mounts
- /etc/hosts → localhost entries
- /etc/passwd → 14 system users + tester user
- /etc/group → 33 system groups
- /var/log/{btmp,lastlog,faillog,wtmp} → log files
- After exec /usr/bin/bash --login prompt changed to:
  (lfs chroot) root:/# ← Glitchix recognizes root!

## Packages Built Inside Chroot
| Package | Version | Purpose |
|---|---|---|
| Gettext | 1.0 | Only msgfmt, msgmerge, xgettext copied |
| Bison | 3.8.2 | Parser generator |
| Perl | 5.42.0 | Scripting language for build scripts |
| Python | 3.14.3 | Needed by Meson and other tools |
| Texinfo | 7.2 | Documentation system |
| Util-linux | 2.41.3 | System utilities (mount, fdisk, etc) |

## Notes
- Python OpenSSL warning during build = NORMAL, ignore it
- Perl man page installation disabled = NORMAL
- No DESTDIR=$LFS needed anymore - we're inside Glitchix!

## Section 7.13 — Cleanup
```bash
rm -rf /usr/share/{info,man,doc}/*   # saved ~35MB
find /usr/{lib,libexec} -name \*.la -delete  # removed libtool archives
rm -rf /tools  # saved ~1GB - cross toolchain no longer needed
```

## Backup Created
Backup saved at: $HOME/lfs-temp-tools-13.0-systemd.tar.xz
To restore if needed:
```bash
cd $LFS && rm -rf ./*
tar -xpf $HOME/lfs-temp-tools-13.0-systemd.tar.xz
```

## What's Next
Chapter 8 — Installing the full, final system packages (80+ packages!)
This is the longest chapter but the most rewarding.