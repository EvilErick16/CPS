TITLE Counting Alphanumeric Characters (Hwk05.asm)
;Erick Juarez
;Compiler: Microsoft VS 2015 Community 
;This program reads an entire line of text, counts the occurences 
;of each alphanumeric chareacter, and outputs the results 

INCLUDE Irvine32.inc

.data 
buffer    BYTE 133 DUP(0)     ; input buffer , holds 132 characters, plus a null at the end
charCount BYTE 36 DUP (0)     ; holds the number of occurences 
charTest  BYTE 30h, 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 61h, 62h, 63h, 64h, 65h, 66h, 67h,
   68h, 69h, 6Ah, 6Bh, 6Ch, 6Dh, 6Eh, 6Fh, 70h, 71h, 72h, 73h, 74h, 75h, 76h, 77h, 78h, 79h, 7Ah 
byteCount DWORD ?             ; holds starting counter for bufferLoop 
outerCount  DWORD ?           ; saves the outer loop counter while inner loop is looping 
displayMsg  BYTE " - ",0                ;mesages for output 
welcomeMsg  BYTE "Start typing: ",0     
outputMsg   BYTE "Char - Occurences"    

.code
main PROC 
    mov     edx, OFFSET welcomeMsg   ; move offset of welcome message to edx
    call    WriteString              ; display welcome message

    mov     edx, OFFSET buffer      ; points to the buffer
    mov     ecx, SIZEOF buffer      ; max number of characters 
    call    ReadString              ; input the string 
    mov     byteCount, eax          ; store the number of bytes used in the string 

    mov     ecx, byteCount      ; set bufferLoop counter
    mov     edi, 0              ; clear edi register
bufferLoop:
    mov     outerCount, ecx     ; save bufferLoop counter 
    mov     ecx, 36             ; set charTestLoop counter
    mov     esi, 0              ; clear esi register
charTestLoop:
    mov     ah, [buffer + edi]      ; ah is the current evaluating char 
    mov     al, [charTest + esi]    ; charTest holds all the values 0-9 and a-z 
    cmp     ah, al                  ; compare current evaluating char and vals in charTest
    jne     noMatch                 ; jumps to label if the characters are not the same
    inc     [charCount + esi]       ; if characters are the same, increment number of occurences 
   
noMatch:

    inc     esi                     ; increment esi inside charTestLoop
    loop    charTestLoop            ; repeat charTestLoop 
    inc     edi                     ; increment edi inside bufferLoop 
    mov     ecx, outerCount         ; restore bufferLoop counter 
    loop    bufferLoop              ; repeat bufferLoop 

    mov     edx, OFFSET outputMsg   ; edx = outputMsg address 
    call    WriteString             ; display outputMsg
    call    Crlf                    ; new line 
    mov     ecx, 36                 ; set loop counter to 36 
    mov     esi, 0                  ; clear esi register 
    mov     edx, OFFSET displayMsg  ; edx = displayMsg address 
displayLoop:
    mov     al, [charTest + esi]    ; move the items in charTest to al 
    call    WriteChar               ; display current char
    call    WriteString             ; display displayMsg
    movzx   eax, [charCount + esi]  ; move number of occurences to eax
    call    WriteDec                ; display number of occurences 
    call    Crlf                    ; new line 
    inc     esi                     ; increment index 
    loop    displayLoop             ; loop back

    exit

main ENDP
END main 