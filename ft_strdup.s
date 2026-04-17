extern malloc
extern __errno_location
extern ft_strlen
extern ft_strcpy

section .text
    global ft_strdup

; ── ft_strdup ────────────────────────────────────────
; firma:    ft_strdup(const char *src) → char *
; logica:   alloca strlen(src)+1 byte, copia src, ritorna il nuovo puntatore.
;           malloc fallita → imposta errno=ENOMEM, ritorna NULL.
;           src NULL → undefined behavior (segfault), come da man.
; registri: rdi = src poi size per malloc, rsi = src recuperato dallo stack, rax = ritorno
; nota:     src salvato con push prima delle call (rdi è caller-saved nell'ABI x86-64).
; ─────────────────────────────────────────────────────

ft_strdup:
    push rdi                    ; preserva src: le call seguenti sovrascrivono rdi
    call ft_strlen
    inc rax                     ; +1 per '\0'
    mov rdi, rax
    call malloc wrt ..plt       ; wrt ..plt necessario per eseguibili gcc su linux
    test rax, rax
    jz .error                   ; malloc fallita → bilancia il push prima di uscire
    pop rsi                     ; src originale → secondo arg di ft_strcpy
    mov rdi, rax                ; nuovo buffer → primo arg di ft_strcpy
    call ft_strcpy              ; ritorna dst (la copia duplicata)
    ret

.error:
    pop rsi                     ; bilancia il push
    mov rdi, 12                 ; ENOMEM = 12
    call __errno_location wrt ..plt
    mov [rax], rdi
    xor rax, rax                ; ritorna NULL
    ret
