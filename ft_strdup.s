extern malloc
extern __errno_location
extern ft_strlen
extern ft_strcpy

section .text
    global ft_strdup

; ============================================================
; ft_strdup - Duplica una stringa allocando nuova memoria
; ============================================================
; PARAMETRI:
;   rdi = puntatore alla stringa da duplicare (src)
; RITORNA:
;   rax = puntatore alla nuova stringa duplicata
;         NULL (0) in caso di errore di allocazione
; LOGICA:
;   1. Calcola la lunghezza della stringa con ft_strlen
;   2. Alloca lunghezza+1 byte con malloc (il +1 è per il '\0')
;   3. Copia la stringa originale nel nuovo buffer con ft_strcpy
;   In caso di errore malloc, imposta errno = 12 (ENOMEM) e ritorna NULL.
; REGISTRI USATI:
;  rax = valore di ritorno di ft_strlen, poi di malloc, poi di ft_strcpy (= dst)
;  rdi = parametro per ft_strlen, poi per malloc (size), poi per ft_strcpy (dst)
;  rsi = recuperato dallo stack, usato come src per ft_strcpy
; NOTE SUI PUSH/POP:
;   Le chiamate a funzioni (ft_strlen, malloc) possono sovrascrivere
;   i registri caller-saved (come rdi). Per questo salviamo rdi sullo
;   stack con push prima della call e lo recuperiamo con pop dopo.
; ============================================================

ft_strdup:
    xor rax, rax                    ; azzera rax per sicurezza
    push rdi                        ; salva rdi sullo stack: ft_strlen lo sovrascriverà
    call ft_strlen                  ; calcola la lunghezza della stringa → risultato in rax
    inc rax                         ; +1 per includere il carattere null '\0' nell'allocazione
    mov rdi, rax                    ; sposta la dimensione in rdi (parametro di malloc)
    call malloc wrt ..plt           ; alloca la memoria (wrt ..plt = PIE compliant)
    test rax, rax                   ; testa se malloc ha ritornato NULL (allocazione fallita)
    jz .error                       ; se NULL → salta alla gestione dell'errore
    pop rsi                         ; recupera il puntatore originale della stringa in rsi (src per ft_strcpy)
    mov rdi, rax                    ; sposta il puntatore del nuovo buffer in rdi (dst per ft_strcpy)
    call ft_strcpy                  ; copia la stringa originale (rsi) nel nuovo buffer (rdi)
    ret                             ; ritorna rax (ft_strcpy ritorna il puntatore dst = nuova stringa)

.error:
    pop rsi                         ; ripristina lo stack (bilancia il push iniziale)
    mov rdi, 12                     ; carica 12 in rdi: ENOMEM = errore "memoria esaurita"
    call __errno_location wrt ..plt ; ottieni il puntatore alla variabile errno → rax
    mov [rax], rdi                  ; scrive il valore di errno (12 = ENOMEM) all'indirizzo puntato da rax
    xor rax, rax                    ; azzera rax: malloc ritorna NULL in caso di errore
    ret                             ; ritorna NULL (0)
