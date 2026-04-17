section .text
    global ft_strcmp

; ============================================================
; ft_strcmp - Confronta due stringhe carattere per carattere
; ============================================================
; PARAMETRI:
;   rdi = puntatore alla prima stringa (s1)
;   rsi = puntatore alla seconda stringa (s2)
; RITORNA:
;   rax = 0  se le stringhe sono identiche
;         >0 se il primo carattere diverso di s1 è maggiore di quello di s2
;         <0 se il primo carattere diverso di s1 è minore di quello di s2
; LOGICA:
;   Confronta i byte uno ad uno. Si ferma quando trova due byte
;   diversi tra loro, oppure quando entrambi sono '\0' (fine stringa).
;   Il risultato è la differenza aritmetica tra i due byte divergenti.
;   movsx serve a estendere correttamente il segno quando il risultato
;   è negativo (altrimenti un valore negativo in 8 bit non verrebbe
;   rappresentato correttamente in rax a 64 bit).
; REGISTRI USATI:
;  rax / al = byte corrente di s1 + valore di ritorno
;  cl       = byte corrente di s2
; ============================================================

ft_strcmp:
    xor rax, rax            ; azzera rax (conterrà il risultato finale)
    test rsi, rsi
    jz .finish
    test rdi, rdi
    jz .finish

.loop:
    movzx eax, byte [rdi]   ; carica s1[i] come unsigned in eax (zero-extend, evita signed overflow)
    movzx ecx, byte [rsi]   ; carica s2[i] come unsigned in ecx
    cmp al, cl              ; confronta i due byte
    jne .finish             ; se sono diversi → abbiamo il risultato, salta a finish
    test al, al             ; testa se il byte è zero (fine stringa; al == cl qui)
    je .finish              ; se sì → stringhe identiche, salta a finish
    inc rdi                 ; avanza il puntatore di s1
    inc rsi                 ; avanza il puntatore di s2
    jmp .loop               ; torna all'inizio del loop

.finish:
    sub eax, ecx            ; differenza unsigned: \xFF(255) - \x01(1) = 254 (positivo, corretto)
    ret
