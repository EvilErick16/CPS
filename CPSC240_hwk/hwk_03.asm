TITLE Add and Subtract (hwk_03.asm)
; Erick Juarez
; 9/27/17
; Microsoft Visual Studio 2015 Community
; This program adds and subtracts 32-bit integers 
; and stores the sum in a variable
; It performs the following equation: A = ((A - B) + (A + D)) + C 

INCLUDE Irvine32.inc

.data
valA    DWORD 20            
valB    DWORD 10
valC    DWORD 30
valD    DWORD 15
finalVal DWORD ?

.code
main PROC

    mov     eax,valA            ; EAX = 20
    mov     ebx,valB            ; EBX = 10
    mov     ecx,valC            ; ECX = 30
    mov     edx,valD            ; EDX = 15
    sub     eax,ebx             ; 20 - 10, EAX = 10
    add     edx,valA            ; 15 + 20, EDX = 35
    add     ecx,edx             ; 30 + 35, ECX = 65
    add     eax,ecx             ; 10 + 65, EAX = 75
    mov     finalVal,eax        ; store final value 
    call    WriteDec            ; display finalVal
    call    DumpRegs            ; display the registers 
    call    DumpMem
    call    WaitMsg

    exit 
main ENDP

END main