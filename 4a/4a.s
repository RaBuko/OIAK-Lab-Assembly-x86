# lab4 - podana liczbe wypisz na ekran,
# zamien na dwojkowy schematem Hornera i wypisz na ekran,
# zamine na szesnastkowy bazami skojarzonymi i wypisz na ekran

 # nazwy symboliczne do wywoływania funkcji systemowych (adm/unistd.h)
.data
 SYSEXIT = 1
 SYSREAD = 3
 SYSWRITE = 4
 SYSOPEN = 5
 STDIN = 0
 STDOUT = 1
 EXIT_SUCCESS = 0

 BUF_SIZE = 32 # rozmiar bufora na napis
.align 32

input: .space BUF_SIZE
binreprraw: .space 256
binreprnorm: .space 256
binreprAscii: .space 256
hexrepr: .space 32
hexreprnorm: .space 32
length: .int 0

.text
    newline: .ascii "\n"
    newlineLen = . - newline
    .globl _start # punkt wejscia do programu

_start:

# pobranie od użytkownika ciągu znaków
mov $SYSREAD, %rax
mov $STDIN, %rbx
mov $input, %rcx
mov $length, %rdx
int $0x80

mov %rax, length # przekazanie długości wczytanego ciagu jako length
sub $1, length   # odjecie dlugosci znaku aby nie brac pod uwage znaku nowej linii

# wypisanie oryginalnej liczby
mov $SYSWRITE, %rax
mov $STDOUT, %rbx
mov $input, %rcx
mov length, %rdx
int $0x80

mov $SYSWRITE, %rax
mov $STDOUT, %rbx
mov $newline, %rcx
mov $newlineLen, %rdx
int $0x80

mov $0, %rdx

# przygotowanie rejestrow
mov $0, %r8        # tu bedzie przechowywana liczba
mov $1, %rbx        # tu jest mnoznik pozycji
mov $10, %rcx       # system liczbowy
mov (length), %rsi  # tu zachowana będzie ilosc cyfr
sub $1, %rsi        # nalezy odjac poniewaz zacznie czytac ZA liczba

# petla zapisujaca wartosc podanej liczby w systemie B=10 (w r8)
to10:
    cmp $0, %rsi
    jl end10
    mov $0, %rax
    mov input(, %rsi, 1), %al
    sub $48, %al
    mul %rbx
    add %rax, %r8
    mov %rbx, %rax
    mul %rcx
    mov %rax, %rbx
    dec %rsi
    jmp to10
end10:

# przygotowanie rejestrow
mov %r8, %rax   # zapamietanie liczby do konwersji
mov $2, %rbx    # system liczbowy
mov $0, %rcx    # pozycja zapisania

# petla zapisujaca wartosc podanej liczby w systemie B=10 (w r8)
to2:
    mov $0, %rdx    # tu przechowywana reszta z dzielenia
    div %rbx        # podzielenie przez system liczbowy
    mov %rdx, binreprraw(, %rcx, 1)    # w rdx pozostala reszta z dzielenia
    inc %rcx        # przesun sie o pozycje
    cmp $0, %rax    # sprawdz czy liczba ktora zostala do dzielenia nie jest juz 0
    jne to2         # jesli tak to kontynuujemy
end2:

# liczba w tym systemie niestety zostala zapisana odwrotnie

mov %rcx, %r9 # zapamietanie dlugosci liczby binarnej
dec %rcx  # odjecie od dlugosci 1 dla indeksowania od tylu
mov $0, %rdx  # indeks przedni

reverse:
    movb binreprraw(, %rcx, 1), %al
    movb %al, binreprnorm(, %rdx, 1)
    add $48, %al
    movb %al, binreprAscii(, %rdx, 1)
    inc %rdx
    dec %rcx
    cmp $0, %rcx
    jge reverse
endreverse:

mov %r8, %rsi
mov %r9, %rdi

mov $SYSWRITE, %rax
mov $STDOUT, %rbx
mov $binreprAscii, %rcx
mov %r9, %rdx
int $0x80

mov $SYSWRITE, %rax
mov $STDOUT, %rbx
mov $newline, %rcx
mov $newlineLen, %rdx
int $0x80


mov $0, %rbx
mov $0, %rcx

to16:
    movl binreprraw(, %rcx, 1), %eax
    jmp parse
    afterparse:
    inc %rbx
    add $4, %rcx
    cmp %rcx, %rdi
    jg to16
end16:

dec %rbx
mov $0, %rax
mov $0, %rdx
reverse2:
    movb hexrepr(, %rbx, 1), %al
    movb %al, hexreprnorm(, %rdx, 1)
    inc %rdx
    dec %rbx
    cmp $0, %rbx
    jge reverse2
endreverse2:

mov $SYSWRITE, %rax
mov $STDOUT, %rbx
mov $hexreprnorm, %rcx
int $0x80

mov $SYSWRITE, %rax
mov $STDOUT, %rbx
mov $newline, %rcx
mov $newlineLen, %rdx
int $0x80

mov $SYSEXIT, %rax
mov $EXIT_SUCCESS, %rbx
int $0x80




parse:
cmp $0x00000000, %eax
je get0

cmp $0x00000001, %eax
je get1

cmp $0x00000100, %eax
je get2

cmp $0x00000101, %eax
je get3

cmp $0x00010000, %eax
je get4

cmp $0x00010001, %eax
je get5

cmp $0x00010100, %eax
je get6

cmp $0x00010101, %eax
je get7

cmp $0x01000000, %eax
je get8

cmp $0x01000001, %eax
je get9

cmp $0x01000100, %eax
je getA

cmp $0x01000101, %eax
je getB

cmp $0x01010000, %eax
je getC

cmp $0x01010001, %eax
je getD

cmp $0x01010100, %eax
je getE

cmp $0x01010101, %eax
je getF

get0:
movb $'0', hexrepr(, %rbx, 1)
jmp afterparse
get1:
movb $'1', hexrepr(, %rbx, 1)
jmp afterparse
get2:
movb $'2', hexrepr(, %rbx, 1)
jmp afterparse
get3:
movb $'3', hexrepr(, %rbx, 1)
jmp afterparse
get4:
movb $'4', hexrepr(, %rbx, 1)
jmp afterparse
get5:
movb $'5', hexrepr(, %rbx, 1)
jmp afterparse
get6:
movb $'6', hexrepr(, %rbx, 1)
jmp afterparse
get7:
movb $'7', hexrepr(, %rbx, 1)
jmp afterparse
get8:
movb $'8', hexrepr(, %rbx, 1)
jmp afterparse
get9:
movb $'9', hexrepr(, %rbx, 1)
jmp afterparse
getA:
movb $'A', hexrepr(, %rbx, 1)
jmp afterparse
getB:
movb $'B', hexrepr(, %rbx, 1)
jmp afterparse
getC:
movb $'C', hexrepr(, %rbx, 1)
jmp afterparse
getD:
movb $'D', hexrepr(, %rbx, 1)
jmp afterparse
getE:
movb $'E', hexrepr(, %rbx, 1)
jmp afterparse
getF:
movb $'F', hexrepr(, %rbx, 1)
jmp afterparse
