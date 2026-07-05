
%include "asm_io.inc"


segment .bss
    Array resd 100 ;reserve space for 100 integers
    Sum resd 1 ;total added number (sum) space for 1 integer


segment .text
    global asm_main

asm_main:
    enter 0,0 ;enters a stack frame to run code

    mov ecx, 0 ; sets the starting value position of the array (the ecx register tracks the current index position as the loop runs)
    mov eax, 1 ;sets the starting value of the array (the eax register tracks the current number as the loop runs)

ArrayFillLoop:
    cmp ecx, 100 ;check if value in ecx is over 100 (only needs to go to 99)
    jge FillFinished ;end the loop by jumping to the fill finished label

    mov [Array + ecx*4], eax ;converts the ecx index pos into memory format by converting into 4bytes (32bit integer) so the cpu can store the data.

    add ecx , 1 ;increases loop iteration position by 1 inside ecx
    add eax , 1 ;increases loop iteration array value by 1 inside eax
    
    jmp ArrayFillLoop ;loops until 100 is reached

FillFinished:
    mov ecx, 0 ;resets index positions so cpu can access each memory location 1 by 1
    mov eax, 0 ;resets eax so it can be used for caclulating the sum

SumLoop:
    cmp ecx, 100 ;check if value in ecx is over 100 (if at 100 then all values have been processed)
    jge SumFinish ;end the loop by jumping to the sum finish label

    add eax, [Array + ecx*4] ;adds up all values from ram to then be processed by cpu

    add ecx , 1 ;moves up one position so its synced up with 32bit address
    jmp SumLoop ;run loop again until all numbers added

SumFinish:
    call print_int ;prints the output
    call print_nl ;format line

    leave ;resets stack frame to where it was before enter
    ret ;return
