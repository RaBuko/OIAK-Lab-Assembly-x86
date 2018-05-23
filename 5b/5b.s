lib_path: .string "/home/rab/Pulpit/OIAK/5b/libfunc.so" # sciezka do biblioteki
func_name: .string "function"	# nazwa wywoływanej funkcji
str: .ascii "Wypisanie dlugiego i bardzo fajnego napisu!\n"  # (1)

.global main

main:
	mov $1, %esi           # tryb 'zaladuj adres funkcji w chwili wywolania'
	mov $lib_path, %edi    # przekazanie sciezki do biblioteki
	call dlopen            # otworzenie biblioteki

	mov %eax, %edi         # adres biblioteki przekazany jest jako argument
	mov $func_name, %esi   # przekazanie nazwy funkcji
	call dlsym             # wydobycie z biblioteki adresu funkcji

    mov $str, %ecx     # przekazanie napisu jako argument wyowlywanej funkcji
	call *%rax         # wywolanie funkcji

    call exit           # wyjscie z programu
