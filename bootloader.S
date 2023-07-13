        ## Boot, say hello, and halt (AT&T assembly)

.code16 # 16 bit mode
.global _start

_start:
    movb $0xe, %ah # Modo TTY

    # for(si = msg, *si != 0; si++)
    movw $msg, %si
    loop:
        movb (%si), %al
        cmp $0x0, %al
        je halt # Dá halt

        int $0x10 # Call BIOS video service

        add $1, %si
        jmp loop
    loop_end:

    halt:
        hlt
        jmp halt

msg: .string "Hello World"

# Torna midia bootavel
.fill 510 - (. - _start), 1, 0
.word 0xaa55
