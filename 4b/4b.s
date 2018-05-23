# lab4b - wczytaj liczbe szesnastkoa i wyspisz dziesietna

.data
format_x: .ascii "%x"
format_d: .ascii "%d"
number: .space 32

.text
   .globl main # punkt wejscia do programu

main:

mov $0, %rax
mov $format_x, %rdi
mov $number, %rsi
call scanf

mov $0, %rax
mov $format_d, %rdi
mov number, %rsi
call printf

mov $0, %rax
call exit
