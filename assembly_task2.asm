; Ammar Khaled Abd An_Noor / 2nd year medical informatics section #1
; assembly task 2
; a program to find result = (a^3 * b) + (5 * b^2) such that a = 20 , b = 40
 

data segment
    
    a DW 20
    b DW 40
    result DD ?  ; double  word to hold the answer
    
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
    
    
    MOV AX, a  ; AX = 20
    MUL a      ; DX:AX = AX * 20 = 20 * 20 = 400
    MUL a      ; DX:AX = AX * 20 = 400 * 20 = 8000
    MUL b      ; DX:AX = AX * 40 = 8000 * 40 = 320000   
    
    
    ; MOVE DX:AX to result
    MOV result, AX
    MOV word ptr [result+2], DX
    
    
    MOV AX, 5  ; AX = 5
    MUL b      ; DX:AX = AX * 40 = 5 * 40 = 200
    MUL b      ; DX:AX = AX * 40 = 200 * 40 = 8000
    
    
    ; adding DX:AX to result 
    ADD result, AX  
    ADC word ptr [result+2], DX
    ; result = 328000
            
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
