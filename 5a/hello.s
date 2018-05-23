.text
hello:
    .ascii "Hello, world\n"
helloLen = . - hello
.global _start
_start:
    mov $4, %eax
    mov $1, %ebx
    mov $hello, %ecx
    mov $helloLen, %edx
    int $0x80
    ret
