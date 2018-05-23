# lab1 - program wypisujący na ekranie Hello, world!

# nazwy symboliczne do wywoływania funkcji systemowych (adm/unistd.h)
SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0
SYS_CALL = 0x80

.align 32 # wyrownanie kodu programu do granicy slowa maszynowego
.text

hello:
    .ascii "Hello, world\n"
helloLen = . - hello # róznica biezacej pozycji w sekcji .text (.) i etykiety hello

.global _start # punkt wejscia do programu

/*
Wywoływanie funkcji systemowych:
1. Umieszczenie numeru funkcji w rejestrze eax
2. Umieszczenie jej argumentow w rejestrach ebx, ecx ...
3. wykonanie przerwania programowego 0x80
*/

_start:
    # 1 funkcja - wypisanie Hello, world
    mov $SYSWRITE, %eax # funkcja do wywołania - SYSWRITE
    mov $STDOUT, %ebx # wyjście standardowe - 1 argument
    mov $hello, %ecx # adres początkowy napisu - 2 argument
    mov $helloLen, %edx # dlugosc lancucha - 3 argument
    int $SYS_CALL # wykonanie funkcji systemowej - wywołanie przerwania programowego

    # 2 funkcja - wyjście z programu
    mov $SYSEXIT, %eax # funkcja do wywołania - SYSEXIT
    mov $EXIT_SUCCESS, %ebx # 1 arg - kod wyjscia z programu
    int $SYS_CALL
