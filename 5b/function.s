.global function
.text
function:
	mov $4, %eax
	mov $1, %ebx
	mov $44, %edx
    int $0x80
    ret
