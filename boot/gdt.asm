CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

gdt_start:
    gdt_null:  ; Mandatory for the first 8 Bytes to be zero
        dd 0x0
        dd 0x0

    gdt_code:  ; Code segment descriptor
        dw 0xffff  ; Limit (0-15)
        dw 0x0  ; Base (0-15)
        db 0x0  ; Base (16-23)
        db 0b10011010  ; 1. Flag, type flags
        db 0b11001111  ; 2. Flag, limits (16-19)
        db 0x0  ; Base (24-31)
        
        
    gdt_data:  ; Data segment descriptor
        dw 0xffff  ; Limit (0-15)
        dw 0x0  ; Base (0-15)
        db 0x0  ; Base (16-23)
        db 0b10010010  ; 1. Flag, type flags
        db 0b11001111  ; 2. Flag, limits (16-19)
        db 0x0  ; Base (24-31)
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

