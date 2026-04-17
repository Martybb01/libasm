section .text
    global ft_strcpy

; ── ft_strcpy ────────────────────────────────────────
; firma:    ft_strcpy(char *dst, const char *src) → char *dst
; logica:   copia src in dst byte per byte, incluso '\0'. src/dst NULL → no-op.
; registri: rdi = dst (avanza nel loop), rsi = src (avanza), rax = dst originale, cl = byte corrente
; nota:     rax = dst salvato subito perché rdi viene modificato nel loop
; ─────────────────────────────────────────────────────

ft_strcpy:
    mov rax, rdi            ; salva dst originale (valore di ritorno)
    test rsi, rsi           ; src NULL → no-op
    jz .done
    test rdi, rdi           ; dst NULL → no-op
    jz .done

.loop:
    mov cl, [rsi]
    mov [rdi], cl
    test cl, cl             ; '\0' copiato → fine stringa
    je .done
    inc rsi
    inc rdi
    jmp .loop

.done:
    ret
