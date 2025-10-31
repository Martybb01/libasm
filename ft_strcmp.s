section .text
    global ft_strcmp

; movsx --> move to superior registry (eax prende valore di al) e lo facciamo nel caso in cui il risultato sia negativo perchè non ci sta in 8bit

ft_strcmp:
    xor rax, rax
    
.loop:
    mov al, [rsi] ; prende primo byte all'indirizzo di memoria rsi
    mov bl, [rdi]
    cmp al, bl
    jne .finish
    test al, bl
    je .finish
    inc rsi
    inc rdi
    jmp .loop

.finish:
    sub al, bl
    cmp al, 0
    jl .convert
    ret

.convert:
    movsx eax, al
    ret
