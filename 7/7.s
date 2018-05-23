.data
format_d: .ascii "%d"

lower_message: .ascii "Podaj dolny przedzial: \0"
upper_message: .ascii "Podaj gorny przedzial: \0"
bounds_message: .ascii "Wybrany przedzial to: \0"
theta = 2

.bss
    .comm lower_bound, 10
    .comm upper_bound, 10
    .comm parts_number, 10

.text
   .globl main # punkt wejscia do programu

main:
    call loadData
    call alg
    call endprogram

alg:
    push (lower_bound)
    finit
    fsin
    pop %rax
    ret

loadData:
    mov $0, %rax
    mov $lower_message, %rdi
    call printf

    mov $0, %rax
    mov $format_d, %rdi
    mov $lower_bound, %rsi
    call scanf

    mov $0, %rax
    mov $upper_message, %rdi
    call printf

    mov $0, %rax
    mov $format_d, %rdi
    mov $upper_bound, %rsi
    call scanf
    ret

endprogram:
    mov $0, %rax
    call exit
