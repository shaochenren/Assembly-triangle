;====================================================PROGRAM INFORMATION==============================================================
;Program Name: Area of Triangle
;Programming Language: x86 Assembly
;
;Purpose: This program asks the user to input 3 floats number to give the length of
;the 3 sides of a triangle. and compute the area of the triangle and showed to user
;
;program Description: area.asm asks user to input 3 values, 
;and check if its vaild, and calculate the area.
;Max page width: 279 columns
;Compile: g++ -c -g -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17
;         gcc -c -g -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11
;         nasm -g -F dwarf -f elf64 -o area.o area.asm
;Link: g++ -m64 -no-pie -o a.out -std=c++17 isfloat.o triangle.o area.o 
;Execute: ./a.out
;
;
;Author: shaochenren
;Email: renleo@csu.fulelrton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-05
;Start Date: 20 November, 2020
;======================================================COPYRIGHT/LICENSING============================================================
;Copyright (C) 
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.

;==========================================================START OF CODE============================================================
extern scanf
extern printf
extern isfloat
extern atof
global area

section .data
    enterNum db "Enter the floating point lengths of the 3 sides of your triangle", 10, 0
    side db "Side %ld: ", 0
    stringOutputFormat db "%s", 0
    floatOutputFormat db "%lf ", 0
    valuesReceived db "These values were received: ", 0
    newLine db "", 10, 10, 0
    invalid db "An invalid input was detected. Please run program again", 10, 0
    negative db "Only positive values are allowed. Terminating", 10, 0
    Area db "The area of this triangle is %lf square meters", 10, 0
    invalidTriangle db "This is not a valid triangle. Terminating", 10, 0

section .bss
    triangle: resq 3           ;The 3 sides of the rectangle


section .text
area:

    ;PUSHES
    push rbp                        
    mov rbp, rsp 
    push rdi 
    push rsi
    push rdx 
    push rcx
    push r8 
    push r9 
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf
    push rax
    ;==========================================================================================================

    ;Introduction
    xor rax, rax
    mov rdi, stringOutputFormat
    mov rsi, enterNum
    call printf

    mov r15, 1              
    mov r14, 0              

Input:                  ;Start of loop
    cmp r15, 3
    jg viewContents

    ;==========================================ENTERING IN SIDES===============================================

    ;Stating which side
    xor rax, rax
    mov rdi, side
    mov rsi, r15
    call printf

    ;Taking user input
    push qword 0                            
    xor rax, rax
    mov rdi, stringOutputFormat
    mov rsi, rsp                            ;store top of stack
    call scanf

    ;Seeing if user input is float
    xor rax, rax
    mov rdi, rsp 
    call isfloat
    cmp rax, 0                              ;Returns 1 if is a float. 0 if not a float
    je invalidInput

    ;Converting string value into float
    xor rax, rax
    mov rdi, rsp
    call atof
    movsd xmm15, xmm0                       
    pop rax                                 
                                            ;The xmm15 becomes the new user input after passing all validations

    ;Checking if user input is negative
    mov r13, 0
    movq xmm3, r12                          ;Setting some value to zero to compare with xmm15
    ucomisd xmm15, xmm3                     ;Comparing user input with 0
    jbe negativeInput


    movsd [triangle + r14 * 8], xmm15       ;Moving xmm15 into triangle array

    ;Jumping back to start of loop
    inc r14
    inc r15
    jmp Input

viewContents:

    xor rax, rax
    mov rdi, stringOutputFormat
    mov rsi, valuesReceived
    call printf

    mov r15, 0      

startLoop:          ;Looping 3 times to print each side of triangle
    cmp r15, 3
    je arithmetic

    ;Printing each side of triangle
    push qword 0
    mov rax, 1
    mov rdi, floatOutputFormat
    movq xmm0, [triangle + r15 * 8]
    call printf
    pop r11

    inc r15
    jmp startLoop

    ;============================IF INPUT IS NOT NUMBBER OR IS NEGATIVE========================================
invalidInput:
    
    ;Tells the user their input is invalid
    xor rax, rax
    mov rdi, stringOutputFormat
    mov rsi, invalid
    call printf
    pop rax                                 ;Making up to the pop from the scanf

    ;Moving 0 into xmm15 to be returned 
    mov r15, 0x0000000000000000
    movq xmm15, r15

    jmp end

negativeInput:

    ;Tells the user float is negative
    xor rax, rax
    mov rdi, stringOutputFormat
    mov rsi, negative
    call printf 
    
    ;Moving 0 into xmm15 to be returned 
    mov r15, 0x0000000000000000
    movq xmm15, r15

    jmp end
arithmetic:

    ;New line character
    xor rax, rax
    mov rdi, stringOutputFormat
    mov rsi, newLine
    call printf

    mov r13, 0x0000000000000000         
    movq xmm14, r13                     ;Used to take in sum of all 3 sides 
    addsd xmm14, [triangle]            
    addsd xmm14, [triangle + 8]         
    addsd xmm14, [triangle + 16]        

    ;sum/2 to find s
    mov r13, 0x4000000000000000         
    push r13                            
    movsd xmm13, [rsp]                  
    pop r13                             
    divsd xmm14, xmm13                  

    ;Finding (s - a), storing into xmm13
    movsd xmm13, xmm14
    subsd xmm13, [triangle]
    
    ;Finding (s - b), storing into xmm12
    movsd xmm12, xmm14
    subsd xmm12, [triangle + 8]

    ;Finding (s - c), storing into xmm11
    movsd xmm11, xmm14
    subsd xmm11, [triangle + 16]

    ;Finding s(s - a)(s - b)(s - c), storing all into xmm14
    mulsd xmm14, xmm13
    mulsd xmm14, xmm12
    mulsd xmm14, xmm11

    ;Seeing if product is less than or equal to zero 
    mov r10, 0
    movq xmm10, r10                     ;Used to compare with xmm14 (Product)
    ucomisd xmm14, xmm10
    jb notTriangle

    ;Finding square root of s(s - a)(s - b)(s - c)
    sqrtsd xmm15, xmm14                 ;Storing answer into xmm15
    jmp end

notTriangle: 

    ;Tells the user this is an invalid triangle
    xor rax, rax
    mov rdi, stringOutputFormat
    mov rsi, invalidTriangle
    call printf

    ;Moving 0 into xmm15 to be returned 
    mov r15, 0x0000000000000000
    movq xmm15, r15

    ;==========================================================================================================

end:
    ;Printing what the area is
    push qword 99
    mov rax, 1
    mov rdi, Area
    movsd xmm0, xmm15
    call printf
    pop rax

    movsd xmm0, xmm15                

    ;POPS
    pop rax
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp 

    ret                                 ;Returns value in xmm0 to main
