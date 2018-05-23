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

x/AAABC &ADRES/ZMIENNA
wyswietla wartosc danego adresu/zmiennej
AAA to ilosc fragmentow wielkosci B (b - 8b, h - 16b, w - 32b)
Prezentuje je w sposob C (c - ASCII, d - dziesietnie, x - hex (16) )
Przykład: x/50bc &textout - wyswietla 50 znakow ASCII z bufora textout

## Assembler GAS

movb, movw, movl, movq <A> <B> - kopiuje A do B
8b    16b   32b   64b

movxz <A> <B> - kopiuje A do B wraz z rozszerzeniem, czyli powieksza kopiowana
wartosc A do rozmiaru B wypelniajac to zerami, mozna kopiowac wiec z mniejszego do wiekszego
