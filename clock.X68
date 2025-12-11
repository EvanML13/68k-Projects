HARDWARE    EQU     $E00000         ;base address of hardware devices

            ORG    $8000
START:      MOVE.L  #32,D0          ;task number 32
            CLR.B   D1              ;parameter: display window
            TRAP    #15             ;system call
            
            MOVE.L  #ISR6,$78       ;place address of the level-6 ISR into the vector table
            
            CLR.B   HH              ;sets hours to zero
            CLR.B   MM              ;sets minutes to zero
            CLR.B   SS              ;sets seconds to zero
            MOVE.B  #40,COUNTER     ;initializes counter to 60
                        
MAIN        LEA     HARDWARE,A1     ;point to base
            LEA     CONVERT,A2      ;point to conversion table
            
            MOVE.B  HH,D1           ;gets the hours value 
            MOVE.W  #0,D2           ;sets offset to zero so hours can be written at the most significant bit 
            BSR     DISPLAY         ;display hours 
            
            MOVE.B  #$40,4(A1)      ;writes dash in between hours and minutes
            
            MOVE.B  MM,D1           ;gets the minutes value
            MOVE.W  #6,D2           ;sets offset 
            BSR     DISPLAY         ;display minutes
            
            MOVE.B  #$40,10(A1)     ;writes dash in between minutes and seconds 
            
            MOVE.B  SS,D1           ;gets the seconds value
            MOVE.W  #12,D2          ;sets offset
            BSR     DISPLAY         ;display seconds 
            
            BRA     MAIN            ;loop
            
DISPLAY     MOVEM.L D3-D4,-(SP)     ;save working registers
            
            MOVE.B  D1,D3           ;load value of the digits into D3
            DIVU    #10,D3          ;divide by 10 to get the most significant bit
            
            MOVE.W  D3,D4           ;copy the result into D4
            ANDI.W  #$00FF,D4       ;gets the quotient which will be the most significant bit of the digit
            MOVE.B  (A2,D4.W),D4    ;get 7-segment pattern for the tens digit
            MOVE.B  D4,(A1,D2.W)    ;write digit to 7-segment display
            
            ROR.L   #8,D3           ;rotate right to bring down the upper word
            ROR.L   #8,D3           
            
            ANDI.W  #$00FF,D3       ;gets the remainder which is now in the most significant bit
            MOVE.B  (A2,D3.W),D3    ;get 7-segment pattern for the tens digit
            MOVE.B  D3,2(A1,D2.W)   ;write digit to 7-segment display
            
            MOVEM.L (SP)+,D3-D4     ;restore working registers
            RTS                     ;return

ISR6        MOVEM.L D0-D1/A0,-(SP)  ;save registers used
            
            SUB.B   #1,COUNTER      ;decrement counter
            CMP.B   #0,COUNTER      ;check if counter is at 0
            BNE     EXIT            ;if not exit
            MOVE.B  #60,COUNTER     ;if counter is at 0 reset to 60
            
            ADD.B   #1,SS           ;increment seconds
            CMP.B   #60,SS          ;check if seconds is at 60 
            BNE     EXIT            ;if not exit
            CLR.B   SS              ;if seconds is at 60 reset to 0
            
            ADD.B   #1,MM           ;increment minutes
            CMP.B   #60,MM          ;check if minutes is at 60
            BNE     EXIT            ;if not exit
            CLR.B   MM              ;if minutes is at 60 reset to 0
            
            ADD.B   #1,HH           ;increment hours
            CMP.B   #24,HH          ;check if hours is at 24
            BNE     EXIT            ;if not exit
            CLR.B   HH              ;if hours is at 24 reset to 0
            
EXIT        MOVEM.L (SP)+,D0-D1/A0  ;restore working registers
            RTE                     ;return 

*
* 7-Segment LED patterns for digits 0-7
CONVERT     DC.B    $3F, $06, $5B, $4F, $66, $6D, $7D, $07, $7F, $6F

*
* Global variables
HH          DS.B    1
MM          DS.B    1
SS          DS.B    1
COUNTER     DS.B    1

            END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
