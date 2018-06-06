.data

format_f:           .ascii "%f\0"
format_sum:         .ascii "%f\0"

start_value_info:   .ascii "Podaj dolny przedzial: \0"
max_value_info:     .ascii "Podaj gorny przedzial: \0"

maxvalue:           .float 1.000    # górny przedział
sum:                .float 0.000    # suma długości łuku
differ:             .float 0.001    # przedział
a_x:                .float 0.000    # aktualnie badana wsp. x
a_y:                .float 0.000    # aktualnie badana wsp. y
b_x:                .float 0.000    # poprzednia badana wsp. x
b_y:                .float 0.000    # poprzednia badana wsp. y
a:                  .float 0.000    # roznica x-ow
b:                  .float 0.000    # roznica y-ow

.text
   .globl main

main:
    call loadData   # funkcja wczytująca przedzialy
    call algorithm  # wykonanie calego algorytmu
    call endprogram # zakonczenie programu

algorithm:
    call setpositions # funkcja ustawiajaca zmienne pozycji
    call calcsin      # funkcja obliczajaca sinus dla danego x
    call calc_dist  
    flds maxvalue
    fcom a_x
    fnstsw  # przeniesienie flag FPU
    sahf    # przyjecie tych flag jako flagi procesora (potrzebne do skokow)
    jnb algorithm
    ret

calc_dist:
    finit
    flds a_x
    fsub b_x 
    fsts a
    fmul a
    fsts a

    finit
    flds a_y
    fsub b_y
    fsts b
    fmul b
    fsts b
    
    finit
    flds a
    fadd b
    fsqrt
    fadd sum
    fsts sum

    ret

setpositions:
    mov a_x, %rax
    mov %rax, b_x
    mov a_y, %rax
    mov %rax, b_y

    finit
    flds a_x
    fadd differ
    fsts a_x
    ret

calcsin:
    finit
    flds a_x
    fsin
    fsts a_y
    ret

loadData:
    mov $start_value_info, %rdi
    call printf

    mov $format_f, %rdi 
    mov $a_x, %rsi  # wstawienie jako pierwszą wspołrzędna x wartości wspianej przez użytkownika
    call scanf

    mov $max_value_info, %rdi
    call printf

    mov $format_f, %rdi
    mov $maxvalue, %rsi
    call scanf
    ret

endprogram:
    mov $0, %rax
    call exit
