section .text
    global ft_strcmp

; ── ft_strcmp ────────────────────────────────────────
; firma:    ft_strcmp(const char *s1, const char *s2) → int
; logica:   confronta s1 e s2 come unsigned char (standard C).
;           ritorna s1[i]-s2[i] al primo byte diverso, 0 se uguali.
; registri: rdi = s1, rsi = s2, eax = byte s1/ritorno, ecx = byte s2
; nota:     movzx (zero-extend) garantisce semantica unsigned: 0xFF = 255, non -1
; ─────────────────────────────────────────────────────

ft_strcmp:
    xor rax, rax
    test rdi, rdi           ; NULL guard (UB in C, difensivo)
    jz .done
    test rsi, rsi
    jz .done

.loop:
    movzx eax, byte [rdi]   ; carica byte s1[i] come unsigned (zero-extend)
    movzx ecx, byte [rsi]
    cmp al, cl              ; al sono gli 8bit meno significativi di eax e cl di ecx
    jne .done               ; byte diversi → calcola differenza
    test al, al             ; al == cl: se '\0' → fine stringa
    je .done
    inc rdi
    inc rsi
    jmp .loop

.done:
    sub eax, ecx            ; differenza unsigned → risultato in rax
    ret
