section .text
    global ft_strlen

; mov si usa x copiare il secondo valore dichiarato nel primo
; prima cosa svuotare il rax x sicurezza con mov rax, 0 o xor che prende due registri da svuotare
; rax sarà il nostro iteratore
; [] --> indirizzo di memoria
; je --> jump if equal
; jle --> jump if less or equal
; jme --> jump if more or equal
; jmp --> jump / goto
; jne --> jump if not equal
; jz --> jump if zero
; il valore ritornato sarà sempre rax (quindi ret contiene rax)
; test comando x vedere se la stringa è nulla
; x compila --> nasm -f elf64 -g
; x testare --> creare un main su file .c e dichiarare la funzione external ft_strlen

ft_strlen:
    xor rax, rax

.loop:
    mov bl, rsi[rax]
    cmp bl, 0
    je .finish
    inc rax
    jmp .loop

.finish:
    ret

