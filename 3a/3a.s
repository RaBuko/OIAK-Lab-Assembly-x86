# lab3a - podany ciag zamien litery duze na male, a male na duze

 # nazwy symboliczne do wywoływania funkcji systemowych (adm/unistd.h)
 SYSEXIT = 1
 SYSREAD = 3
 SYSWRITE = 4
 SYSOPEN = 5
 STDIN = 0
 STDOUT = 1
 EXIT_SUCCESS = 0
 SYS_CALL = 0x80

 BUF_SIZE = 1000 # rozmiar bufora na napis
.align 32

.data
string: .space BUF_SIZE
text_size: .int 0
ascii_border = 92

newline: .ascii "\n"
    newlineLen = . - newline

.text
    .global _start # punkt wejscia do programu

_start:
    mov $SYSREAD, %eax # funkcja do wywołania - SYSREAD
    mov $STDIN, %ebx   # 1arg - strumien
    mov $string, %ecx  # 2arg - adres początkowy napisu
    mov $text_size, %edx # 3arg - dlugosc lancucha
    int $SYS_CALL
    mov %eax, text_size

    mov $0, %ecx
    mov $1, %edx
    sub $1, text_size # odjecie dlugosci znaku aby nie brac pod uwage znaku nowej linii
    for:
        add $string, %ecx
        cmpb $ascii_border, (%ecx)
        jl uppercase
        sub $64, (%ecx)
        uppercase: add $32, (%ecx)

        mov $SYSWRITE, %eax
        mov $STDOUT, %ebx
        int $SYS_CALL
        add $1, %ecx
        sub $string, %ecx
        cmp text_size, %ecx
        jl for

    # nowy znak linii
    mov $SYSWRITE, %eax
    mov $STDOUT, %ebx
    mov $newline, %ecx
    mov $newlineLen, %edx
    int $SYS_CALL

    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $SYS_CALL
