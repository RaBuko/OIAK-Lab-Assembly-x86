.data
  format: .ascii "%[^/]"
  filename: .string "/home/rab/Pulpit/OIAK/6/hello"
  file_open_mode: .string "r"
  txt_to_display: .ascii "Dlugi i fajny napis do wypisania\n"

.text
.global main

main:
  call execute
  call exit

execute:
  mov $file_open_mode, %esi # tryb otwarcia pliku - czytanie
  mov $filename, %edi       # nazwa pliku
  call fopen                # wykonanie funkcji fopen

  push %rbp       # zapamietanie RBP z poprzedniej funkcji (czyli main)
  mov %rsp, %rbp  # uaktualnienie RBP aby wskazywał na aktualną ramkę
  sub $8, %rsp    # w tym momecie przesuwam sie aby nie nadpisac

  mov %rax, %rdi     # przekazanie desktyptora pliku
  lea -8(%rbp), %rdx # przekazanie funkcji z miejsca w ktorym pamietam ze byla zapisana w pamieci
  mov $format, %esi  # format czytania
  call fscanf        # wykonanie fscanf

  lea -8(%rbp), %rax        # zwracam w rax adres zapisanego kodu
  mov $txt_to_display, %rcx # jako parametr podaje tekst
  call *%rax                # wykonanie zapisanej funkcji

  leave # w momencie wywołania RET na szczycie stosu będzie adres pod jaki program powinien skoczyć
ret     # zdjęcie tego adresu i wykonanie skoku
