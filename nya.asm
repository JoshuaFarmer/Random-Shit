org 7C00h ; The bootloader should start at memory address 0x7C00

section.text:
    ; Infinite loop to ensure the bootloader keeps running
    mov ax, 0
    mov ds, ax
    mov si,text
print_char:
    lodsb       ; Load the next character from DS:SI into AL
    cmp al, 0   ; Check if it's the null terminator
    je hang     ; If it is, hang
    mov ah, 0x0E ; BIOS teletype function
    int 10h     ; Call BIOS to print character in AL
    jmp print_char ; Continue printing characters

hang:
    cli         ; Disable interrupts
    hlt         ; Halt the CPU

text db "nya",0

times 510-($-$$) db 0   ; Fill the rest of the boot sector with zeros
dw 0xAA55              ; Boot signature (required)
