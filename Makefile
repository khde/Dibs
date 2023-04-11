CC = gcc
LD = ld
AS = nasm

CFLAGS = -Wall -Wextra -Wpedantic -nostdlib -nostdinc -nostartfiles \
		 -fno-stack-protector -fno-pie -nostartfiles -fno-builtin   \
		 -nodefaultlibs -m32
LDFLAGS =  -m elf_i386
ASFLAGS = -f bin

iso: kernel.bin boot.bin
	dd if=/dev/zero of=dibs.iso bs=512 count=2880
	dd if=boot.bin of=dibs.iso conv=notrunc bs=512 seek=0 count=1
	dd if=kernel.bin of=dibs.iso conv=notrunc bs=512 seek=1 count=2048

boot.bin: boot/boot.asm
	$(AS) $(ASFLAGS) boot/boot.asm -o $@

kernel.bin: kernel/kernel.c
	$(CC) $(CFLAGS) -c kernel/kernel.c -o kernel.o
	$(LD) $(LDFLAGS) -o $@ -Ttext 0x1000 kernel.o --oformat binary
	
run: iso
	qemu-system-i386 -fda dibs.iso

clean:
	rm -f boot.bin
	rm -f kernel.o
	rm -f kernel.bin
