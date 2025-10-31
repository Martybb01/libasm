extern malloc
extern __errno_location
extern ft_strlen
extern ft_strcpy

section .text
    global ft_strdup

; malloc prende rdi come parametro e mette il puntatore dentro rax
; push prima di malloc e strlen, pop dopo il malloc xkè malloc sminchia tutto

ft_strdup:
    xor rax, rax
    push rsi
    call ft_strlen
    inc rax ; x '/0' xkè rax ora tiene la lunghezza di rsi
    mov rdi, rax
    call malloc wrt ..plt
    test rax, rax
    jz .error
    pop rsi
    ; a sto point in rax c'è l'indirizzo di memoria della nuova stringa
    mov rdi, rax ; xkè strcpy prende rsi e rdi
    call ft_strcpy
    ret


.error:
    pop rsi
    mov rdi, 12 ; xke errno prende rdi e malloc ha errore 12 standard
    call __errno_location wrt ..plt
    mov [rax], rdi
    xor rax, rax ; xke malloc torna nullo 
    ret

