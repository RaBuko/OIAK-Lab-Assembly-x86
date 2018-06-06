.data
format_d: .ascii "%d\0"
format_f: .ascii "%f\0"

lower_message: .ascii "Podaj dolny przedzial: \0"
upper_message: .ascii "Podaj gorny przedzial: \0"
bounds_message: .ascii "Wybrany przedzial to: \0"

differ: .double 0.1
.space 1
input: .float 3.14
output: .float 0
length: .float 0

c_w_precision_double_extended:
	.word 0x037f

.bss
    .comm lower_bound, 4
    .comm upper_bound, 4
    .comm parts_number, 4
    .comm answer, 4

.text
   .globl main

main:
    call loadData
    call alg
    call endprogram

alg:
    finit
    flds input
    fcos
    fsts output
    call printfloat
br:
ret

printfloat:
    mov $0, %rax
    mov $differ, %rdi
    mov $format_f, %rsi
    call printf
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
