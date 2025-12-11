printASCII  EQU     $2D0E
DUART       EQU     $A001
MR1A        EQU     0*2
MR2A        EQU     1*2
SRA         EQU     2*2
CSRA        EQU     3*2
CRA         EQU     4*2
RBA         EQU     5*2

    ORG $2000
INITIALIZE
    INCBIN 'duart_h.BIN'
    ORG     $4000
START:                              ;first instruction of program
    BSR     INITIALIZE
    
    MOVEA.L #DUART,A0               ;Initialize pointer to DUART base 
    
    MOVE.B  #$02,MR1A(A0)       ;7 data bits with parity
    MOVE.B  #$07,MR2A(A0)       ;1 stop bit
    move.b  #$99,CSRA(A0)       ;baud rate of 4800
    move.b  #$05,CRA(A0)        ;enable tx/rx

LOOP:
    MOVE.B  SRA(A0),D0         ;read status register
    BTST    #0,D0              ;bit 0 = receive ready
    BEQ     LOOP               ;keep polling if not char is recived

    MOVE.B  RBA(A0),D0         ;move recived char into D0 

    CMP.B   #0,D0              ;checks if the recived char is the null terminator
    BEQ     END                ;ends if a null terminator is recived

    BSR     printASCII         ;prints ASCII for character
    BRA     LOOP               ;read the next char

    SIMHALT
    
END:
    SIMHALT

    END    START        ;last line of source




























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
