###OIAK

## MAKEFILE

prog: prog.o
	ld -o prog prog.o

prog.o: prog.s
	as -o prog.o prog.s

## GDB

break ADRES/ETYKIETA - punkt przerwania w danym punkcie
run - uruchamia do najblizszego punktu przerwania
step - do nastpnego punktu przerwania
stepi - wykonaj krok o jedna instrhukcje
stepi <n> - wykonaj n instrukcji

Examine memory: x/FMT ADDRESS.
ADDRESS is an expression for the memory address to examine.
FMT is a repeat count followed by a format letter and a size letter.
Format letters are 
o(octal), x(hex), d(decimal), u(unsigned decimal, t(binary), f(float), a(address), i(instruction), c(char), s(string) and z(hex, zero padded on the left).
Size letters are b(byte), h(halfword), w(word), g(giant, 8 bytes).
The specified number of objects of the specified size are printed
according to the format.

Defaults for format and size letters are those previously used.
Default count is 1.  Default address is following last thing printed
with this command or "print".

## Assembler GAS

movb, movw, movl, movq <A> <B> - kopiuje A do B
8b    16b   32b   64b

movxz <A> <B> - kopiuje A do B wraz z rozszerzeniem, czyli powieksza kopiowana
wartosc A do rozmiaru B wypelniajac to zerami, mozna kopiowac wiec z mniejszego do wiekszego

## FPU

# Przemieszczanie danych

FLD/FILD [mem]-załaduj liczbę rzeczywistą/całkowitą 
z pamięci. Dla liczby rzeczywistej jest to 32, 64 lub 80 
bitów. Dla całkowitej16, 32 lub 64 bity.
FST [mem32/64/80] do pamięci idzie liczba ze st(0).
FSTP [mem32/64/80] zapisz st(0) w pamięci i zdejmij je ze stosu. Znaczy to tyle, że st(1) o ile istnieje, staje się st(0) itd. każdy rejestr cofa się o 1.
FIST [mem16/32] ewentualnie obciętą do całkowitej 
liczbę z st(0) zapisz do pamięci.
FISTP [mem16/32/64] jak wyżej, tylko ze zdjęciem ze 
stosu.
FXCH st(i) zamień st(0) z st(i).