#!/bin/bash

#Author: shaochenren
#Program name: Area of Triangle 
#Language: Bash


rm *.o, *.out

#C++
g++ -c -g -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17

#C
gcc -c -g -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11

#ASM
nasm -g -F dwarf -f elf64 -o area.o area.asm

#Linker
g++ -m64 -no-pie -o a.out -std=c++17 isfloat.o triangle.o area.o 

./a.out

echo "End Program"
