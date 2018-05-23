6: 6.s
	gcc 6.s -o 6 -g -ldl

hello: hello.o
	ld -o hello hello.o

hello.o: hello.s
	as -o hello.o hello.s
