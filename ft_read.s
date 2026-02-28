extern __errno_location

section .text
    global ft_read

; ============================================================
; ft_read - Legge bytes da un file descriptor
; ============================================================
; PARAMETRI:
;   rdi = file descriptor da cui leggere (es. 0 = stdin)
;   rsi = puntatore al buffer in cui salvare i dati letti
;   rdx = numero massimo di byte da leggere
; RITORNA:
;   rax = numero di byte effettivamente letti (successo)
;         -1 in caso di errore (errno viene impostato)
; LOGICA:
;   Esegue la syscall read (numero 0 su Linux x86-64).
;   Il kernel scrive in rax il numero di byte letti, oppure
;   un valore negativo (-errno) in caso di errore.
;   In caso di errore: neghiamo rax per ottenere il codice
;   di errore, lo salviamo in errno e ritorniamo -1.
; REGISTRI USATI:
;  rax = numero syscall (1) poi valore di ritorno
; ============================================================

ft_read:
    mov rax, 0                      ; syscall numero 0 = read (Linux x86-64 ABI)
    syscall                         ; esegue la syscall → rax = byte letti, o valore negativo se errore
    cmp rax, 0                      ; confronta il risultato con 0
    jl .error                       ; se rax < 0 → errore, salta a .error
    ret                             ; altrimenti ritorna rax (numero di byte letti)

.error:
    neg rax                         ; inverte il segno: da -errno → +errno (il codice di errore positivo)
    mov rdi, rax                    ; salva il codice di errore in rdi (rax verrà sovrascritto dalla call)
    call __errno_location wrt ..plt ; ottieni il puntatore alla variabile errno → rax
    mov [rax], rdi                  ; scrive il codice di errore all'indirizzo di errno
    mov rax, -1                     ; imposta rax a -1 (valore di ritorno standard per errore)
    ret                             ; ritorna -1
