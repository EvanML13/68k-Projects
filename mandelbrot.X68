FP_mul  EQU $1088

    ORG     $1000
START
    INCBIN 'N4.BIN'
 
Iterate
    LINK    A6,#-16     ;allocate storage for 16 bytes
    MOVEM.L D1/A1,-(SP) ;save working registers
    
    MOVE.L  8(A6),D1    ;sets D1 = x
    MOVE.L  16(A6),A1   ;sets A1 = &iteration
    
    CLR.L   -4(A6)      ;clears register so a=0
    CLR.L   -8(A6)      ;clears register so b=0
    CLR.L   D0          ;clears D0 register to store the address of Iterate
    MOVE.L  D0,(A1)     ;sets *iteration = 0
    
LOOP

    ;iteration < 100
    MOVE.L  (A1),D0     ;gets the value of *iteration
    CMP.L   #100,D0     ;iteration < 100 ?
    BGE     EXIT        ;exits the loop if iteration >= 100
    
    ;a*a
    MOVE.L  -4(A6),-(SP) ;pushes a
    MOVE.L  -4(A6),-(SP) ;pushes a
    JSR     FP_mul      ;jumps to the multiplication subroutine
    ADDQ.L  #8,SP       ;pops the parmaeter
    MOVE.L  D0,-16(A6)  ;gets the value of a*a  
    
    ;+b*b
    MOVE.L  -8(A6),-(SP) ;pushes b
    MOVE.L  -8(A6),-(SP) ;pushes b
    JSR     FP_mul      ;jumps to the multiplication subroutine
    ADDQ.L  #8,SP       ;pops the parmaeter
    ADD.L   D0,-16(A6)  ;adds the value of b*b to a*a  
    
    ;b<1024
    CMP.L   #1024,-16(A6)  ;compares if the computed with 1024
    BGE     EXIT        ;exits if the computed value >= 1024
    
    ;enters while loop

    ;a*a
    MOVE.L  -4(A6),-(SP)    ;pushes a
    MOVE.L  -4(A6),-(SP)    ;pushes a
    JSR     FP_mul  ;jumps to the multiplication subroutine
    ADDQ.L  #8,SP   ;pops the parameter
    MOVE.L  D0,-12(A6)  ;gets the value of a*a

    ;-b*b
    MOVE.L  -8(A6),-(SP)    ;pushes b
    MOVE.L  -8(A6),-(SP)    ;pushes b
    JSR     FP_mul  ;jumps to the multiplication subroutine
    ADDQ.L  #8,SP   ;pops the parameter
    SUB.L   D0,-12(A6)  ;gets the value of a*a - b*b  
    
    ;+x
    MOVE.L  -12(A6),D0  ;moves the value into D0
    ADD.L   8(A6),D0    ;adds the value of x to D0
    MOVE.L  D0,-12(A6)  ;moves the value back to memory
    
    ;a*b << 1 + y
    MOVE.L  -4(A6),-(SP)    ;pushes the value of a
    MOVE.L  -8(A6),-(SP)    ;pushes the value of b
    JSR     FP_mul  ;jumps to the multiplication subroutine
    ADDQ.L  #8,SP
    ASL     #1,D0       ;pops the paramaeter
    ADD.L   12(A6),D0   ;adds the value of y
    MOVE.L  D0,-8(A6)   ;moves the value back into memory
    
    MOVE.L  -12(A6),-4(A6) ;a = t
    
    ;increments the value of iteration by 1    
    MOVE.L  (A1),D0
    ADDQ.L  #1,D0
    MOVE.L  D0,(A1)

    BRA     LOOP    ;goes back to the start of the loop
    
EXIT
    MOVEM.L (SP)+,D1/A1 ;restore registers
    UNLK    A6  ;unlinks
    RTS ;returns to subroutine
  
    END    START        ; last line of source













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
