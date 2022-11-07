; Ammar Khaled Abd An_Noor / 2nd year medical informatics section #1
; assembly task 1
; a program to find result = (3! + 4! + 5! + 6! + 7!)/5 


data segment
    arr dw 3, 4, 5, 6, 7
    factArr dw 5 dup(0)   ; to hold factorials of arr elements
    five dw 5 
    result dw ?
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
    
    ; start of code;
    
    mov bx, 0 ;set bx to point to the first element in arr
      
    
loopOnArr:         ; to find each factorial
    
    mov ax, arr[bx]

loopForFactorial:
    dec arr[bx]
    mul arr[bx]
    cmp arr[bx], 1
    jne loopForFactorial
    
    mov factArr[bx], ax ;save factorials in factArr     
    add bx, 2
    cmp bx, 10
    jne loopOnArr
       
    ; end of calculating factorials
        
    mov ax, 0
    mov bx, 0
    
loopForSum:   ; accumulate the factorials in AX register
    add ax, factArr[bx]
    add bx, 2
    cmp bx, 10
    jne loopforSum
            
    div five
    
    mov result, ax ; at this point result is 1182       
        
            
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
