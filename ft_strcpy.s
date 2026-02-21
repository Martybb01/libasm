section .text
    global ft_strcpy

; rdi = dst (destinazione)
; rsi = src (sorgente)

ft_strcpy:
    mov rax, rdi        ; salva il puntatore di dst per il return
    
.loop:
    mov cl, [rsi]       ; carica il byte corrente da src
    mov [rdi], cl       ; copia il byte in dst
    test cl, cl         ; check se si è raggiungo '\0' --> jump to finish
    je .finish
    inc rsi             
    inc rdi             
    jmp .loop           

.finish:
    ret                 ; ritorna rax --> contiene il puntatore originale a dst