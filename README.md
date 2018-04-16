The purpose of this snapshot of the Linux em28xx driver is so that
I can easily apply this trivial patch to my current Linux 4.15 kernel
so that I can use my Hauppauge WinTV Dual HD tuner.

```
--- em28xx-cards.c.orig	2018-04-14 15:50:34.468784364 -0500
+++ em28xx-cards.c	2017-12-25 20:58:33.143021470 -0600
@@ -2550,6 +2550,8 @@
 			.driver_info = EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_DVB },
 	{ USB_DEVICE(0x2040, 0x026d),
 			.driver_info = EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_01595 },
+	{ USB_DEVICE(0x2040, 0x826d),
+			.driver_info = EM28174_BOARD_HAUPPAUGE_WINTV_DUALHD_01595 },
 	{ USB_DEVICE(0x0438, 0xb002),
 			.driver_info = EM2880_BOARD_AMD_ATI_TV_WONDER_HD_600 },
 	{ USB_DEVICE(0x2001, 0xf112),
```

Apparently, Hauppauage is shipping a newer version of hardware with newer
USB ID's and support has not been submitted yet officially yet.
Hopefully, it will be submitted any day now:

https://patchwork.kernel.org/patch/10145819/

Build instructions are simple as long as the included DVB framework
headers are compatible with your existing kerenl:

```
$ make
$ sudo cp em28xx.ko /lib/modules/`uname -r`/extra
$ depmod -a
$ modprobe em28xx
```

Although it seems to work fine (in my usage) with current driver, the
hardware change seems to be to suport USB bulk transfers which requires above
complete patchset.

This is a complete copy of the em28xx driver as well as a snapshot
of some dvb framework headers.  If you use this with a different kernel
version, its very important to make sure those header files are compatible
with headers from your kernel version.

For Fedora, I'm obtaining the kernel source that matches currently
installed using these commands:

$ fedpkg clone -a kernel
$ git checkout origin/f27
$ fedpkg prep

The kernel sources will be unpacked and patched under a kernel-* directory.

I then perform a diff of all *.h files included here with in tree headers
to verify if they are compatible and update if needed.

More info: https://fedoraproject.org/wiki/Building_a_custom_kernel
