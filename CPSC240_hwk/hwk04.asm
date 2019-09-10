TITLE Loops and Arrays (hwk04.asm)
;Erick Juarez
;10/14/2017
;Compiler: Microsoft Visual Studio 2015 Community
;This program uses indirect addressing to access and switch
;the 1st and 2nd values of an array, 3rd & 4th, 5th & 6th, and so on... 

INCLUDE Irvine32.inc

.data
warray DWORD 3, 5, 8, 7, 13, 19, 17, 19

.code 
main PROC

    mov     esi, OFFSET warray        ;ESI contains address of warray
    mov     ecx, LENGTHOF warray      ;ECX loop counter
    mov     ebx, TYPE warray          ;EBX = 4
    call    DumpMem                   ;Display array before the operation 
L1:
    mov     edi, [esi]                ;EDI = current element in the array 
    add     esi, ebx                  ;Increment the offset of ESI
    xchg    edi, [esi]                ;Exchange value of EDI and the value of the next element in the array
    sub     esi, ebx                  ;Decrement offset to back to the previous element 
    xchg    edi, [esi]                ;Exchange new value of EDI with current element
    add     esi, ebx
    add     esi, ebx                  ;Increment offset to the next element to be swapped 
    dec     ecx                       ;Decrement ecx loop counter                    
    LOOP L1
    mov     esi, OFFSET warray        ;Put the starting adress of warray back in ESI
    mov     ecx, LENGTHOF warray      ;Put the number of elements back into ECX
    call    DumpMem                   ;Display resulting array
    call    WaitMsg                   ;call wait message
    exit



main ENDP

END main