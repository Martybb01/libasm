section .text
    global ft_strcpy

; ============================================================
; ft_strcpy - Copia una stringa nella destinazione
; ============================================================
; PARAMETRI:
;   rdi = puntatore alla stringa destinazione (dst)
;   rsi = puntatore alla stringa sorgente (src)
; RITORNA:
;   rax = puntatore originale a dst (come da standard C)
; LOGICA:
;   Copia byte per byte da src a dst, incluso il '\0' finale.
;   Salva subito il puntatore dst in rax perché rdi viene
;   modificato durante il loop.
; REGISTRI USATI:
;  rax = copia del puntatore originale a dst (valore di ritorno)
;  cl  = byte corrente
; ============================================================

ft_strcpy:
    mov rax, rdi            ; salva il puntatore originale di dst in rax (sarà il valore di ritorno)

.loop:
    mov cl, [rsi]           ; carica il byte corrente da src in cl
    mov [rdi], cl           ; copia quel byte nella posizione corrente di dst
    test cl, cl             ; testa se cl è zero (carattere null '\0')
    je .finish              ; se è zero → stringa terminata, salta a finish
    inc rsi                 ; avanza il puntatore src al prossimo carattere
    inc rdi                 ; avanza il puntatore dst al prossimo carattere
    jmp .loop               ; torna all'inizio del loop

.finish:
    ret                     ; ritorna rax (puntatore originale a dst, salvato all'inizio)
