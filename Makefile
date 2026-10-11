BUILDROOT ?= $(CURDIR)/buildroot
OUTPUT ?= $(CURDIR)/output
EXTERNAL := $(CURDIR)
DEFCONFIG := $(CURDIR)/configs/agybox_x86_64_defconfig

.PHONY: all config build qemu clean
all: build

config:
	$(MAKE) -C $(BUILDROOT) O=$(OUTPUT) BR2_EXTERNAL=$(EXTERNAL) BR2_DEFCONFIG=$(DEFCONFIG) defconfig

build:
	$(MAKE) -C $(BUILDROOT) O=$(OUTPUT) BR2_EXTERNAL=$(EXTERNAL)

qemu:
	qemu-system-x86_64 -m 256M -smp 2 -kernel $(OUTPUT)/images/bzImage -initrd $(OUTPUT)/images/rootfs.cpio.gz -append 'console=ttyS0,115200n8 rdinit=/sbin/init' -nographic

clean:
	$(MAKE) -C $(BUILDROOT) O=$(OUTPUT) clean
