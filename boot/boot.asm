; boot.asm
bits 16
org 0x7c00

KERNEL_OFFSET equ 0x1000

entry16:
    ; Safe boot drive information from BIOS
    mov [BOOT_DRIVE], dl
    
    ;set up stack
    mov bp, 0x9002
    mov sp, bp

    ; Clear screen
    mov ah, 0x0
    mov al, 0x3
    int 0x10
    
    ; Read Kernel into RAM
    call load_kernel
    
    jc $
    
    call enter_protected_mode
    call CODE_SEG:entry32
    
    jmp $


%include "boot/protected_mode.asm"
%include "boot/load_kernel.asm"
%include "boot/gdt.asm"


bits 32
entry32:
    ; Set up segment register
    mov ax, DATA_SEG
    mov dx, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    ; set up stack
    mov ebp, 0x90000
    mov esp, ebp
    
    ; Enable A20 line (fast)
    in al, 0x92
    or al, 2
    out 0x92, al
    
    ; Go to Kernel
    call 0x1000
    
    jmp $

; Variables
BOOT_DRIVE db 0
msg_pm_mode db "Loaded 32-Bit Protected Mode", 0x0
msg_kernel_loaded db "Loaded Kernel into RAM..", 0x0


times 510-($-$$) db 0x0
db 0x55, 0xaa 
