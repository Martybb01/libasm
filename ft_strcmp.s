section .text
    global ft_strcmp

; movsx --> move to superior registry (eax prende valore di al) e lo facciamo nel caso in cui il risultato sia negativo perchè non ci sta in 8bit

ft_strcmp:
    xor rax, rax
    
.loop:
    mov al, [rdi] ; prende primo byte all'indirizzo di memoria rsi
    mov cl, [rsi]
    cmp al, cl
    jne .finish
    test al, cl
    je .finish
    inc rsi
    inc rdi
    jmp .loop

.finish:
    sub al, cl
    cmp al, 0
    jl .convert
    ret

.convert:
    movsx eax, al
    ret
