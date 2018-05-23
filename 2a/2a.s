# lab2a - wypisanie znaków na nieparzystych miejscach w napisie "Hello, world!"

SYSEXIT = 1 # nazwy symboliczne do wywoływania funkcji systemowych (adm/unistd.h)
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0
SYS_CALL = 0x80

.text
hello:
    .ascii "Hello world!\n"
    helloLen = . - hello # róznica biezacej pozycji w sekcji .text (.) i etykiety hello
.global _start # punkt wejscia do programu

_start:
    mov $1, %edx # dlugosc lancucha 1 znak
    write_char:
        add $hello, %ecx    # dodanie adresu poczatkowego do rejestru ecx
        mov $SYSWRITE, %eax # funkcja do wywołania - SYSWRITE
        mov $STDOUT, %ebx   # wyjście standardowe - 1 argument
        int $SYS_CALL       # wykonanie funkcji systemowej
        add $2, %ecx        # przesuniecie sie o 2 pozycje
        sub $hello, %ecx    # odjecie adresu poczatkowego ciagu znakow
        cmp $helloLen, %ecx # porownanie dlugosci znakuz  aktualna waratoscia ecx
        jl write_char       # petla jesli helloLen ma mniejsza wartosc niz ta w resjestrze ecx
    mov $SYSEXIT, %eax      # funkcja do wywołania - SYSEXIT
    mov $EXIT_SUCCESS, %ebx # kod wyjscia z programu
    int $SYS_CALL
