; Ammar Khaled Abd An_Noor Ibraheem 1st year General Program

data segment
    ; add your data here!
M DB 3, 1, 2, 9, 4, 5, 8, 7, 6 ;save the matrix M
R DW ?
C DW ?
Solution DW 0                  ;save the result
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    mov ax, 0
    
    ; address of element(r,c) = M + (r * DIM) + c
    ;                                 BX      SI                              
;   mov the first required element (0,1) to solution   

MOV R, 0
MOV C, 1
MOV AX, 3
MUL R
MOV BX, AX
MOV SI, C
MOV DL, M[SI+BX]
MOV Solution, DX


;   add the second required element(0,2) to solution
MOV R, 0
MOV C, 2
MOV AX, 3
MUL R
MOV BX, AX
MOV SI, C
MOV DL, M[SI+BX]
ADD Solution, DX


;   add the third required element(1,2) to ax
MOV R, 1
MOV C, 2
MOV AX, 3
MUL R
MOV BX, AX
MOV SI, C
MOV DL, M[SI+BX]
ADD Solution, DX


                    
                        
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.         

