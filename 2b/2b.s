# lab2b - wypisanie ciągu "Hello world!" wspak

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
    mov $1, %edx        # dlugosc lancucha 1 znak
    mov $hello, %ecx    # adres początkowy napisu
    add $helloLen, %ecx # umieszczenie w rejestrze ecx adresu końca napisu
    write_char:
        mov $SYSWRITE, %eax # funkcja do wywołania - SYSWRITE
        mov $STDOUT, %ebx   # wyjście standardowe - 1 argument
        sub $1, %ecx        # przesuniecie adresu odczytwania o 1 pozycję w dół
        int $SYS_CALL       # wykonanie funkcji systemowego
        cmp $hello, %ecx    # porównanie adresu aktualnego znaku do odczytania
        jg write_char       # z początkiem napisu i skok jeśli przekroczono
    mov $SYSEXIT, %eax      # funkcja do wywołania - SYSEXIT
    mov $EXIT_SUCCESS, %ebx # 1 arg - kod wyjscia z programu
    int $SYS_CALL
