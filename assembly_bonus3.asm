; multi-segment executable file template.

data segment
    M DB 3, 1, 2, 9, 4, 5, 8, 7, 6 ;saves the matrix M 
    MT DB 9 DUP(0)                 ;saves the transposed matrix
    R DW ?
    C DW ?
                        
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

    ; offset of element indexed by(r,c) = M + (r * #columns) + c
    ;                                             BX           SI 
    
    ; elements in main diagonal won't change
      
    ;   mov the element (0,0) to MT   
    MOV R, 0
    MOV C, 0
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX]
    MOV MT[SI+BX], CL
    
    ;   mov the element (1,1) to MT   
    MOV R, 1
    MOV C, 1
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX]
    MOV MT[SI+BX], CL
       
    ;   mov the element (2,2) to MT   
    MOV R, 2
    MOV C, 2
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX]
    MOV MT[SI+BX], CL 
    
    ; element(a,b) in M will be element(b,a) in MT
    ;M(0,1) =>  MT(1,0)
    MOV R, 0
    MOV C, 1
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX] 
    
    MOV R, 1
    MOV C, 0
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV MT[SI+BX], CL
    
    ;M(0,2) =>  MT(2,0)
    MOV R, 0
    MOV C, 2
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX] 
    
    MOV R, 2
    MOV C, 0
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV MT[SI+BX], CL
     
    
    ;M(1,0) =>  MT(0,1)
    MOV R, 1
    MOV C, 0
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX] 
    
    MOV R, 0
    MOV C, 1
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV MT[SI+BX], CL   
    
    ;M(1,2) =>  MT(2,1)
    MOV R, 1
    MOV C, 2
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX] 
    
    MOV R, 2
    MOV C, 1
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV MT[SI+BX], CL
    
    ;M(2,0) =>  MT(0,2)
    MOV R, 2
    MOV C, 0
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX] 
    
    MOV R, 0
    MOV C, 2
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV MT[SI+BX], CL
                      
    ;M(2,1) =>  MT(1,2)
    MOV R, 2
    MOV C, 1
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV CL, M[SI+BX] 
    
    MOV R, 1
    MOV C, 2
    MOV AX, 3
    MUL R
    MOV BX, AX
    MOV SI, C
    MOV MT[SI+BX], CL                  
                      
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
