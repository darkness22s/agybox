# Agy Box

Agy Box is a small, text-first x86-64 Linux live system for code work and disposable sandbox sessions. It boots to a root shell without an installer or first-boot wizard. It is a conventional Linux environment, not an AI-specific system.

## What is included

- Linux kernel and BusyBox init/userspace, with a console login on the local terminal and serial console.
- A musl-based Buildroot userspace and lightweight development tools: Git, Python 3, `make`, and common archive/file utilities.
- DHCP on `eth0` when a network interface is available.
- A compressed initramfs image that can be started directly in QEMU or used by a bootloader.

There is no graphical desktop, installer, or persistence by default. Changes made in the live session are lost on reboot. Run untrusted code only inside a properly isolated VM/container: Agy Box itself does not provide a security boundary, and its default console root account is intentionally convenient for a disposable local sandbox.

## Build (Linux host)

Install the host packages required by Buildroot (compiler/build tools, `make`, `wget`/`curl`, `cpio`, `rsync`, `bc`, `file`, `unzip`, and `python3`; package names vary by distribution), then:

```sh
git clone --recurse-submodules https://github.com/darkness22s/agybox.git
cd agybox
make config
make
```

Buildroot is tracked as a Git submodule. On a fresh checkout, `--recurse-submodules` (or `git submodule update --init`) is required. The image is produced at `output/images/rootfs.cpio.gz`; the Linux kernel is at `output/images/bzImage`.

To boot the image in QEMU (install QEMU with x86 system emulation first):

```sh
make qemu
```

Exit QEMU with `Ctrl-A`, then `X`. QEMU's emulated hardware and memory settings are for development; they are not a real-device performance benchmark.

## Resource and boot goals

The project targets under 200 MiB of idle RAM and roughly 2–3 seconds from bootloader handoff to a usable console on supported, fast hardware. These are design goals, **not guarantees**: actual memory use and boot time depend on the kernel configuration, hardware/firmware, device initialization, and how the measurement is defined. The current build has not been benchmarked across physical machines. The text-only design avoids a desktop environment and its persistent background services.

## Project layout

- `configs/agybox_x86_64_defconfig` — Buildroot configuration.
- `board/agybox/rootfs_overlay/` — Agy Box identity and minimal startup configuration.
- `buildroot/` — pinned Buildroot submodule.

## License

The Agy Box project configuration and scripts are licensed under the MIT License (see `LICENSE`). Components built into the image retain their respective upstream licenses.
