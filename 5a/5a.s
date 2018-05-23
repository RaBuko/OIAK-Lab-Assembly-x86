.align 32

BUFOR_SIZE = 10000

.data

dane_file: .ascii "hello.bin\0"
dane: .space BUFOR_SIZE

.global _start # punkt wejscia do programu
.text
_start:
# Otwarcie pliku z ktorego odczytywane beda dane
    mov $5, %eax      # funkcja otwierania pliku
    mov $dane_file, %ebx    # podanie adresu nazwy pliku "dane"
    mov $2, %ecx   # tryb odczytu i zapisu
    int $0x80
    mov %eax, %ebx          # przesuniecie deskryptora pliku do rejestru ebx

# Odczytywanie z pliku
    mov $3, %eax      # odczyt danych
    mov $dane, %ecx         # wskazanie adresu dla pierwszej liczby
    mov $BUFOR_SIZE, %edx     # wskazanie wielkosci bufora
    int $0x80

# Zamkniecie pliku
    mov $6, %eax     # zamkniecie pliku "dane"
    int $0x80

# Wypisanie na ekran
    mov $4, %eax
    mov $1, %ebx
    mov $dane, %ecx
    mov $BUFOR_SIZE, %edx
    int $0x80

# Koniec
    mov $1, %eax
    mov $0, %ebx
    int $0x80
