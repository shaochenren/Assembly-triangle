//====================================================PROGRAM INFORMATION==============================================================
//Program Name: Area of Triangle
//Programming Language: C
//
//Purpose: This program asks the user to input 3 floats number to give the length of
//the 3 sides of a triangle. and compute the area of the triangle and showed to user
//
//File Description: triangle.c is the driver of the program. It introduces the user and calls
//area.asm to get the program started.
//
//Compile: g++ -c -g -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17
//         gcc -c -g -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11
//         nasm -g -F dwarf -f elf64 -o area.o area.asm
//Link: g++ -m64 -no-pie -o a.out -std=c++17 isfloat.o triangle.o area.o 
//Execute: ./a.out
//=====================================================================================================================================
//
//
//=====================================================ABOUT THE AUTHOR================================================================
//Author: shaochenren
//Email: renleo@csu.fullerton.edu
//Institution: California State University, Fullerton
//Course: CPSC 240-05
//Start Date: 20 November, 2020
//=====================================================================================================================================
//
//
//
//======================================================COPYRIGHT/LICENSING============================================================
//Copyright (C) 2020 shaochenren
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
//version 3 as published by the Free Software Foundation.
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
//Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
//======================================================================================================================================


#include<stdio.h>


double area();

int main(){
    double result;

    printf("Welcome to Area of Triangles by shaochenren\n");
    printf("This program will comput the area of your triangle\n");
    result = area();            //Returning area value

    printf("The driver received this number 0x%016lX, and will keep it.\n", *(unsigned long*)&result);       //Printing results
    printf("Now 0 will return to the operating system. Bye\n\n");

    return 0;
}
