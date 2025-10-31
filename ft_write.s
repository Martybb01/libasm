extern __errno_location
section .text
    global ft_write

; impostiamo rax a 1 perchè è il primo valore che prende malloc che va su stdin
; syscall per fare la chiamata di sistema --> mette in rax quanti caratteri ha scritto
; neg x convertire da negativo a positivo e viceversa
; call x chiamare una funzione esterna + wrt ..plt x essere pie compliant
; errno prende come registro di input rdi

ft_write:
    mov rax, 1
    syscall
    cmp rax, 0
    jl .error
    ret

.error:
    neg rax
    mov rdi, rax
    call __errno_location wrt ..plt
    mov [rax], rdi ; impostiamo nell'indirizzo di memoria di rax il valore dell'erno di rdi
    mov rax, -1 ; ritorniamo -1 x errore write
    ret

