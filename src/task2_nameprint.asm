
%include "asm_io.inc"


segment .bss ; blank variable to store integer
    InputInteger resd 1 ; stores 1 input integer (resd used bcuz resd is double words which is 4bytes, 4 bytes is 32 bits, system is 32bit, an integer is 4 bytes)
    Username resb 25 ;variable to store name string (resb used to store strings, reserve 25bytes for strings character limit of 25)


segment .data ;defines variables (db means define byte)
    InputName db "Please enter your name :) ... ", 0
    WelcomeNmbr db "How many times between 50 and 100 do you want this printed? ", 0
    WelcomeMsg db "Welcome ", 0
    ErrorMsg db "Error: Please enter a valid value (50-100)...", 0


segment .text
    global asm_main

asm_main:
    enter 0,0

    ;displays input prompt via terminal
    mov eax, InputName
    call print_string

    mov ebx, Username ;points to where characters will be stored 
    mov ecx, 25 ;sets limit to 25 characters

ReadName:
    call read_char ;reads user input character

    cmp al, 10 ;ascii character 10 is the enter key, if the user presses enter after theyve typed their name...
    je DoneName ;then the process jumps to the DoneName label

    mov [ebx], al ;move the character from al reg into ebx reg 
    inc ebx ;increments position in ebx by 1 so previous character isnt overwritten
    jmp ReadName ;jumps to ReadName (re-runs the loop until enter is pressed)

DoneName:
    mov byte [ebx], 0 ;adds a 0 to the end of the string to mark its end

    ; asks for, obtains, and stores print count number from user then stores the output in eax
    mov eax, WelcomeNmbr 
    call print_string
    call read_int

    ;if value less than 50 then error
    cmp eax, 50
    jl Error

    ;if value more than 100 then error
    cmp eax, 100
    jg Error

    ;stores print count in ecx for use in the loop
    mov ecx, eax

LoopStart:
    mov eax, WelcomeMsg ;move welcome msg to eax register
    call print_string ;prints welcom msg

    mov eax, Username ;move username to eax register
    call print_string ;prints usrname

    call print_nl ;prints new line for formatting

    loop LoopStart ;jumps back to loop start label if ecx (the loop counter) isnt 0 yet

    jmp LoopDone ;finishes loop (when ecx is 0 it ends the loop)

Error:
    mov eax, ErrorMsg ;if the number is invalid moves error msg into eax
    call print_string ;prints errors from eax
    call print_nl ;format new line
    leave
    ret ;return

LoopDone:
    leave ;leave stack
    ret ;return
