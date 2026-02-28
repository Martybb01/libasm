section .text
    global ft_strlen

; ============================================================
; ft_strlen - Calcola la lunghezza di una stringa
; ============================================================
; PARAMETRI:
;   rdi = puntatore alla stringa (char *)
; RITORNA:
;   rax = numero di caratteri della stringa (escluso il '\0' finale)
; LOGICA:
;   Scorre la stringa byte per byte usando rax come indice,
;   finché non trova il carattere null '\0' che segnala la fine.
;   REGISTRI USATI:
;   rax = contatore / valore di ritorno
;   cl  = byte corrente (parte bassa di rcx)
; ============================================================

ft_strlen:
    xor rax, rax            ; azzera rax: lo usiamo come contatore/indice (index = 0)

.loop:
    mov cl, [rdi + rax]     ; carica il byte all'indirizzo (rdi + rax) → carattere corrente
    cmp cl, 0               ; confronta il byte con 0 (carattere null '\0')
    je .finish              ; se è zero → fine della stringa, salta a finish
    inc rax                 ; i++
    jmp .loop               ; torna all'inizio del loop

.finish:
    ret                     ; ritorna rax (= lunghezza della stringa)
