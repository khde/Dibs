enter_protected_mode:
    cli  ; Disable interrupts
    
    lgdt [gdt_descriptor]  ; Load GDT
    
    ; Switch to protected mode
    mov eax, cr0  
    or eax, 0x1  ; Set first Bit
    mov cr0, eax
    ret
