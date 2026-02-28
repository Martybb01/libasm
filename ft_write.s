extern __errno_location

section .text
    global ft_write

; ============================================================
; ft_write - Scrive bytes su un file descriptor
; ============================================================
; PARAMETRI:
;   rdi = file descriptor su cui scrivere (es. 1 = stdout, 2 = stderr)
;   rsi = puntatore al buffer con i dati da scrivere
;   rdx = numero di byte da scrivere
; RITORNA:
;   rax = numero di byte effettivamente scritti (successo)
;         -1 in caso di errore (errno viene impostato)
; LOGICA:
;   Esegue la syscall write (numero 1 su Linux x86-64).
;   Il kernel scrive in rax il numero di byte scritti, oppure
;   un valore negativo (-errno) in caso di errore.
;   In caso di errore: neghiamo rax per ottenere il codice
;   di errore, lo salviamo in errno e ritorniamo -1.
; REGISTRI USATI:
;  rax = numero syscall (1) poi valore di ritorno
; ============================================================

ft_write:
    mov rax, 1                      ; syscall numero 1 = write (Linux x86-64 ABI)
    syscall                         ; esegue la syscall → rax = byte scritti, o valore negativo se errore
    cmp rax, 0                      ; confronta il risultato con 0
    jl .error                       ; se rax < 0 → errore, salta a .error
    ret                             ; altrimenti ritorna rax (numero di byte scritti)

.error:
    neg rax                         ; inverte il segno: da -errno → +errno (il codice di errore positivo)
    mov rdi, rax                    ; salva il codice di errore in rdi (rax verrà sovrascritto dalla call)
    call __errno_location wrt ..plt ; ottieni il puntatore alla variabile errno → rax
    mov [rax], rdi                  ; scrive il codice di errore all'indirizzo di errno
    mov rax, -1                     ; imposta rax a -1 (valore di ritorno standard per errore)
    ret                             ; ritorna -1
