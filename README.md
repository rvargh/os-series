# OS Series – x86_64 Kernel

A simple hobby operating system kernel written in Assembly + C++ for the x86_64 architecture.

## Features

- Multiboot2 compliant
- 64-bit long mode
- Basic identity mapping (first 1 GiB)
- VGA text mode driver written in C++
- Prints "Hello from C++!" on boot

## Requirements

- Docker (recommended) or a cross-compiler toolchain (`x86_64-elf-g++`, `nasm`, `grub`, `xorriso`)
- QEMU

## Building

```bash
make build-x86_64
