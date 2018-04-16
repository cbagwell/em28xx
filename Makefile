ifneq ($(KERNELRELEASE),)
# SPDX-License-Identifier: GPL-2.0
em28xx-y +=	em28xx-core.o em28xx-i2c.o em28xx-cards.o em28xx-camera.o

obj-$(CONFIG_VIDEO_EM28XX) += em28xx.o

ccflags-y += -Idrivers/media/i2c
ccflags-y += -Idrivers/media/tuners
ccflags-y += -Idrivers/media/dvb-core
ccflags-y += -Idrivers/media/dvb-frontends
else

PWD := $(shell pwd)
KERNEL_RELEASE := $(shell uname -r)
KERNEL_DIR = "/lib/modules/${KERNEL_RELEASE}/build"

all:
	@echo '    Building em28xx drivers.'
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD)

modules_install:
	@echo '    Building em28xx drivers.'
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules_install

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) clean

endif
