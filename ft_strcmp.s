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

.loop:
    mov al, [rdi]           ; carica il byte corrente di s1 in al (parte bassa di rax)
    mov cl, [rsi]           ; carica il byte corrente di s2 in cl
    cmp al, cl              ; confronta i due byte
    jne .finish             ; se sono diversi → abbiamo il risultato, salta a finish
    test al, cl             ; testa se entrambi i byte sono zero (fine di entrambe le stringhe)
    je .finish              ; se sì → stringhe identiche, salta a finish
    inc rdi                 ; avanza il puntatore di s1
    inc rsi                 ; avanza il puntatore di s2
    jmp .loop               ; torna all'inizio del loop

.finish:
    sub al, cl              ; calcola la differenza: al - cl (risultato del confronto)
    cmp al, 0               ; controlla se il risultato è negativo
    jl .convert             ; se negativo → serve estensione del segno, salta a convert
    ret                     ; altrimenti rax è già corretto, ritorna

.convert:
    movsx eax, al           ; estende il segno di al (8 bit) a eax (32 bit) per i valori negativi
    ret                     ; ritorna rax con il valore negativo correttamente rappresentato
