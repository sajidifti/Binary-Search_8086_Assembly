;initializing necessary data                          
..data
   Out1    db  "Element Found At Position : "
   Out2    db  " !!$"
   failOut db  "Searched Element Not Found!!!$"
   ArrList dw  12h,28h,100h,212h,228h,534h,550h,888h,980h
   ArrSz   dw  ($-ArrList)/2
   Key     equ 22h
   
   ;starting main code
..code
main proc
              mov ax, @data
              mov ds, ax
     
              mov bx, 00            ;Lower bound to base reg
              mov dx, ArrSz         ;Upper bound to data reg
              mov cx, Key           ;Key to count reg
   ;main function
   mainFunc:  
              cmp bx, dx
              ja  notMatched
                  
              mov ax, bx
              add ax, dx
              shr ax, 1
              mov si, ax
              add si, si
              cmp cx, ArrList[si]
              jae greaterEq
                  
              dec ax
              mov dx, ax
              jmp mainFunc
          
   ;if arrList[mid]<=key
   greaterEq: 
              je  ifMatched
               
              inc ax
              mov bx, ax
              jmp mainFunc
            
   ;if arrList[mid]=key
   ifMatched: 
              add al, 01
              add al, 48
              lea si, Out2
              
              mov [si], al
              lea dx, Out1
              jmp dispOut

   notMatched:
              lea dx, failOut

   dispOut:   
              mov ah, 09h
              int 21h
              mov ah, 4ch
              int 21h
     
main endp
end main
        
