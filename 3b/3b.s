# lab3b - dodaj liczby dodane w pliku "data" a wynik zapisz do "out"
# UWAGA: program dodaje tylko pierwsza cyfre, reszty nie czyta


# nazwy symboliczne do wywoływania funkcji systemowych
SYSOPEN = 5 # otwarcie pliku
SYSCLOSE = 6 # zamkniecie pliku
SYSOPEN_RW = 2 # tryb odczytu i zapisu

SYSREAD = 3 # odczytywanie (z pliku, na ekran(1))
SYSWRITE = 4 # zapisywanie (z pliku, na ekran(1))

SYSEXIT = 1
EXIT_SUCCESS = 0
SYS_CALL = 0x80

.align 32

numBufor = 3
sumBufor = 3

.data

dane_file: .ascii "data\0"
out_file: .ascii "out\0"
num1: .space numBufor
newline: .space 1
num2: .space numBufor
sum: .space sumBufor
left: .int numBufor


.global _start # punkt wejscia do programu
.text
_start:
# Otwarcie pliku z ktorego odczytywane beda dane
    mov $SYSOPEN, %eax      # funkcja otwierania pliku
    mov $dane_file, %ebx    # podanie adresu nazwy pliku "dane"
    mov $SYSOPEN_RW, %ecx   # tryb odczytu i zapisu
    int $SYS_CALL
    mov %eax, %ebx          # przesuniecie deskryptora pliku do rejestru ebx

# Odczytywanie z pliku
    mov $SYSREAD, %eax      # odczyt danych
    mov $num1, %ecx         # wskazanie adresu dla pierwszej liczby
    mov $numBufor, %edx     # wskazanie wielkosci bufora
    int $SYS_CALL

    mov $SYSREAD, %eax      # tutaj nastepuje zapisanie na chwile znaku nowej linii
    mov $newline, %ecx      # nie powinnismy jej dodawac wiec przesuniemy sie w pliku
    mov $1, %edx            # o jedna pozycje
    int $SYS_CALL

    mov $SYSREAD, %eax      # nadpisujemy wczesniej wpisany znak nowej linii
    mov $num2, %ecx         # druga liczba
    mov $numBufor, %edx     # z odpowiednia wielkoscia
    int $SYS_CALL

# Zamkniecie pliku
    mov $SYSCLOSE, %eax     # zamkniecie pliku "dane"
    int $SYS_CALL

# Wypisanie na ekran wczytanych liczb
    mov $SYSWRITE, %eax     # wypisz dane
    mov $1, %ebx            # standardowe wyjście
    mov $num1, %ecx         # adres pierwszej liczby
    mov $numBufor * 2 + 1, %edx # wypisanie wartosci liczby1, znaku nowej linii i liczby2, znajduja sie obok siebie w pamieci
    int $SYS_CALL


    mov $num1 + numBufor, %eax         # przejście na koniec pierwszej liczby
    mov $num2 + numBufor, %ebx         # przejście na koniec drugiej liczby
    mov $sum + sumBufor, %edx          # przejście na koniec pamieci gdzie będzie suma

    sumator:
        sub $1, %eax
        sub $1, %ebx
        sub $1, %edx

        sub $48, (%eax)         # odzyskanie cyfry z kodu ascii
        sub $48, (%ebx)         # odzyskanie cyfry z kodu ascii

        mov (%eax), %ecx        # przekazanie wartosci do rejestru gdzie
        add (%ebx), %ecx        # będzie znajdować się suma
        add $48, %ecx           # przywrócenie kodu ascii
        mov %ecx, (%edx)        # przekazanie wartości do pamięci sumy
        cmp $num1, %eax
        jg sumator

# Wypisanie sumy na ekran
    mov $SYSWRITE, %eax
    mov $1, %ebx
    mov $sum, %ecx
    mov $sumBufor, %edx
    int $SYS_CALL

# Otwarcie pliku do ktorego beda zapisywane dane
    mov $SYSOPEN, %eax      # funkcja otwierania pliku
    mov $out_file, %ebx     # podanie adresu nazwy pliku "out"
    mov $SYSOPEN_RW, %ecx   # tryb odczytu i zapisu
    int $SYS_CALL

    mov %eax, %ebx

# Wypisanie sumy do pliku "out"
    mov $SYSWRITE, %eax
    mov $sum, %ecx
    mov $sumBufor, %edx
    int $SYS_CALL

# Zamknięcie pliku
    mov $SYSCLOSE, %eax     # zamkniecie pliku "out"
    int $SYS_CALL

# Zakończenie programu
    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $SYS_CALL
