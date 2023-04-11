extern KERNEL_OFFSET
extern BOOT_DRIVE

load_kernel:
    mov ah, 0x2  ; Read
    mov al, 15  ; Sectors to read
    mov bx, KERNEL_OFFSET  ; Where to load
    mov ch, 0x0   ; Cylinder
    mov cl, 0x2  ; Sector
    mov dh, 0x0  ; Head
    mov dl, [BOOT_DRIVE]
    int 0x13
    
    ret
