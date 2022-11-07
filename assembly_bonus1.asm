; Ammar Khaled Abd An_Noor / 2nd year medical informatics section #1
; assembly tasks / bonus 1
; a program to multiplty all digits of 8-digit hexadecimal number 


data segment
    A dd 12345678h ; an 8-digit hexadecimal number for example
    digits dw 8 dup(?) ; an array to hold the eight digits
    sixteen dw 16      ; for division
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
    
    ; start of code
    mov bx, 0          ;set BX REG to traverse over digits array
    mov ax, word ptr A ;store the FIRST four digits of A in AX 
    mov si, OFFSET A   
    add si, 2          ;set SI to point to the LAST four digits of A
    mov dx, 0
    
    loopForDigits1:
    div sixteen        ; get each digit as the remainder 
    mov digits[bx], dx ; store each digit in the digits array
    add bx, 2
    cmp bx, 8
    jne loopForDigits1
         
    mov ax, word ptr si ; repeat the previous operation for the last for digits
          
    loopForDigits2:
    div sixteen
    mov digits[bx], dx
    add bx, 2
    cmp bx, 16
    jne loopForDigits2     
    
    
    mov ax, digits   ;move the first digit to AX
    mov bx, 2
    
    loopForMul:      ;calculate the product of the eight digits
    mul digits[bx]
    add bx, 2
    cmp bx, 16
    jne loopForMul
    
    ; at this point AX hold the result which is 40320       
            
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
