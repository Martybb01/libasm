section .text
    global ft_strlen

; ── ft_strlen ────────────────────────────────────────
; firma:    ft_strlen(const char *s) → size_t
; logica:   scorre s byte per byte fino a '\0'. NULL → 0.
; registri: rdi = stringa, rax = contatore/ritorno, cl = byte corrente
; ─────────────────────────────────────────────────────

ft_strlen:
    xor rax, rax
    test rdi, rdi           ; NULL → ritorna 0
    jz .done

.loop:
    mov cl, [rdi + rax]
    cmp cl, 0
    je .done
    inc rax
    jmp .loop

.done:
    ret
