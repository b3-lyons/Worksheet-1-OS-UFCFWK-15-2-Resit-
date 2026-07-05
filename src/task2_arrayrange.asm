
%include "asm_io.inc"


segment .bss
    Array resd 100 ;reserve space for 100 integers
    StartRange resd 1
    EndRange resd 1


segment .data
    StartPrompt db "Enter the range's lowest number (1-100): ", 0
    EndPrompt   db "Enter the range's highest number (1-100): ", 0
    RangeError  db "Invalid range, please try again... ", 0


segment .text
    global asm_main_array

asm_main_array:
    enter 0,0 ;enters a stack frame to run code

    mov ecx, 0 ; sets the starting value position of the array (the ecx register tracks the current index position as the loop runs)
    mov eax, 1 ;sets the starting value of the array (the eax register tracks the current number as the loop runs)

ArrayFillLoop:
    cmp ecx, 100 ;check if value in ecx is over 100 (only needs to go to 99)
    jge RangeInput ;end the loop by jumping to the fill finished label

    mov [Array + ecx*4], eax ;converts the ecx index pos into memory format by converting into 4bytes (32bit integer) so the cpu can store the data.

    add ecx , 1 ;increases loop iteration position by 1 inside ecx
    add eax , 1 ;increases loop iteration array value by 1 inside eax
    
    jmp ArrayFillLoop ;loops until 100 is reached

RangeInput:
    mov eax, StartPrompt ;stores the memory address of the variable's string prompt
    call print_string ;cpu uses memory address to fetch the string out the ram and display to the user
    call read_int ;reads the user's input number (low number of range) and stores it in eax reg 
    mov [StartRange], eax ;takes the user's input number from eax and stores it under startrange in system ram

    mov eax, EndPrompt ;same but for high range number instead
    call print_string
    call read_int 
    mov [EndRange], eax 


    mov eax, [StartRange] ;checks if start number is valid (higher than 1)
    cmp eax, 1
    jl RangeInvalid ;run error code if invalid number is input

    mov eax, [EndRange] ;same but for end range number (cant go over 100)
    cmp eax, 100
    jg RangeInvalid

    mov eax, [StartRange] ;if the start number is higher than the end number it runs the error code
    cmp eax, [EndRange]
    jg RangeInvalid


    mov eax, [StartRange] ;moves the user's start number from ram to eax reg
    sub eax, 1 ;cpu subtracts 1 from the start number so it aligns with the index 0-99 (not 1-100)
    mov [StartRange], eax ;the result of this is taken from the eax reg and put back in the system ram

    mov eax, [EndRange] ;same but for end number
    sub eax, 1
    mov [EndRange], eax


    ; Prepare for summing
    mov ecx, [StartRange] ;loads start index number into ecx reg
    mov eax, 0 ;resets the value so sum doesnt get miscalulated

RangeSumLoop:
    add eax, [Array + ecx*4] ;adds up all values from array in ram

    cmp ecx, [EndRange] ;checks if current iteration has reached the end number yet
    je SumFinish ;if equal the sum is finished calculating

    add ecx, 1 ;goes up by 1 every iteration till end number is reached
    jmp RangeSumLoop ;loops from rangesumloop label till complete

RangeInvalid:
    mov eax, RangeError ;if the number is invalid it moves rangeerror into eax
    call print_string ;prints range error message from eax
    call print_nl ;format new line
    jmp RangeInput ;jumps back up to the range input label so user can try again

SumFinish:
    call print_int ;prints the output
    call print_nl ;format line

    leave ;resets stack frame to where it was before enter
    ret ;return
