extern __errno_location

section .text
    global ft_read

; ── ft_read ──────────────────────────────────────────
; firma:    ft_read(int fd, void *buf, size_t count) → ssize_t
; logica:   esegue la syscall read (n°0). errore → imposta errno, ritorna -1.
; registri: rdi = fd, rsi = buf, rdx = count, rax = n° syscall poi ritorno
; nota:     il kernel ritorna -errno in rax in caso di errore → neg rax per ottenere +errno
; ─────────────────────────────────────────────────────

ft_read:
    mov rax, 0
    syscall
    cmp rax, 0
    jl .error
    ret

.error:
    neg rax                 ; da -errno a +errno
    mov rdi, rax            ; salva errno: rax verrà sovrascritto dalla call
    call __errno_location wrt ..plt
    mov [rax], rdi
    mov rax, -1
    ret
