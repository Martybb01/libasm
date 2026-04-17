extern malloc
extern __errno_location
extern ft_strlen
extern ft_strcpy

section .text
    global ft_strdup

; ── ft_strdup ────────────────────────────────────────
; firma:    ft_strdup(const char *src) → char *
; logica:   alloca strlen(src)+1 byte, copia src, ritorna il nuovo puntatore.
;           src NULL o malloc fallita → imposta errno=ENOMEM, ritorna NULL.
; registri: rdi = src poi size per malloc, rsi = src recuperato dallo stack, rax = ritorno
; nota:     src salvato con push prima delle call (rdi è caller-saved nell'ABI x86-64).
;           due path di errore: prima del push (src NULL) e dopo (malloc fail).
; ─────────────────────────────────────────────────────

ft_strdup:
    test rdi, rdi               ; src NULL → errore (push non ancora fatto)
    jz .error
    push rdi                    ; preserva src: le call seguenti sovrascrivono rdi
    call ft_strlen
    inc rax                     ; +1 per '\0'
    mov rdi, rax
    call malloc wrt ..plt       ; wrt ..plt: necessario per eseguibili PIE
    test rax, rax
    jz .error_pop               ; malloc fallita → bilancia il push prima di uscire
    pop rsi                     ; src originale → secondo arg di ft_strcpy
    mov rdi, rax                ; nuovo buffer → primo arg di ft_strcpy
    call ft_strcpy              ; ritorna dst (la copia duplicata)
    ret

.error_pop:
    pop rsi                     ; bilancia il push → fall-through a .error
.error:
    mov rdi, 12                 ; ENOMEM = 12
    call __errno_location wrt ..plt
    mov [rax], rdi
    xor rax, rax                ; ritorna NULL
    ret
