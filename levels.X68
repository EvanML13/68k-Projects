            ORG    $8000
START:      MOVE.L  #32,D0          ;task number 32
            CLR.B   D1              ;parameter: display window
            TRAP    #15             ;system call

* Place address of the level-1 to level-7 ISR into the vector table
            MOVE.L  #ISR1,$64      
            MOVE.L  #ISR2,$68       
            MOVE.L  #ISR3,$6C       
            MOVE.L  #ISR4,$70       
            MOVE.L  #ISR5,$74
            MOVE.L  #ISR6,$78
            MOVE.L  #ISR7,$7C
            
MAIN        BRA     MAIN

* Interrupt servive routine 1 
ISR1        ORI.W   #$0700,SR       ;sets priority level to 7
            MOVEM.L A1/D0,-(A7)     ;save working registers
            ANDI.W  #$F9FF,SR       ;set priority level to 1
            LEA     MSG1S,A1        ;point to start message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call
            
            MOVE.L  #$00100000,D0   ;initialize loop counter
LOOP1       NOP                     ;perform no operation
            SUB.L   #1,D0           ;decrement loop counter
            BNE     LOOP1           ;do it again
            
            LEA     MSG1E,A1        ;point to end message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call      
            MOVEM.L (A7)+,A1/D0     ;restore working registers
            RTE                     ;use RTE to return from interrupt

* Interrupt service routine 2  
ISR2        ORI.W   #$0700,SR       ;sets priority level to 7
            MOVEM.L A1/D0,-(A7)     ;save working registers
            ANDI.W  #$FAFF,SR       ;set priority level to 2
            LEA     MSG2S,A1        ;point to start message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call
            
            MOVE.L  #$00100000,D0   ;initialize loop counter
LOOP2       NOP                     ;perform no operation
            SUB.L   #1,D0           ;decrement loop counter
            BNE     LOOP2           ;do it again
            
            LEA     MSG2E,A1        ;point to end message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call      
            MOVEM.L (A7)+,A1/D0     ;restore working registers
            RTE                     ;use RTE to return from interrupt

* Interrupt service routine 3  
ISR3        ORI.W   #$0700,SR       ;sets priority level to 7
            MOVEM.L A1/D0,-(A7)     ;save working registers
            ANDI.W  #$FBFF,SR       ;set priority level to 3
            LEA     MSG3S,A1        ;point to start message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call
            
            MOVE.L  #$00100000,D0   ;initialize loop counter
LOOP3       NOP                     ;perform no operation
            SUB.L   #1,D0           ;decrement loop counter
            BNE     LOOP3           ;do it again
            
            LEA     MSG3E,A1        ;point to end message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call      
            MOVEM.L (A7)+,A1/D0     ;restore working registers
            RTE                     ;use RTE to return from interrupt
            
* Interrupt service routine 4  
ISR4        ORI.W   #$0700,SR       ;sets priority level to 7
            MOVEM.L A1/D0,-(A7)     ;save working registers
            ANDI.W  #$FCFF,SR       ;set priority level to 4
            LEA     MSG4S,A1        ;point to start message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call
            
            MOVE.L  #$00100000,D0   ;initialize loop counter
LOOP4       NOP                     ;perform no operation
            SUB.L   #1,D0           ;decrement loop counter
            BNE     LOOP4           ;do it again
            
            LEA     MSG4E,A1        ;point to end message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call      
            MOVEM.L (A7)+,A1/D0     ;restore working registers
            RTE                     ;use RTE to return from interrupt
            
* Interrupt service routine 5  
ISR5        ORI.W   #$0700,SR       ;sets priority level to 7
            MOVEM.L A1/D0,-(A7)     ;save working registers
            ANDI.W  #$FDFF,SR       ;set priority level to 5
            LEA     MSG5S,A1        ;point to start message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call
            
            MOVE.L  #$00100000,D0   ;initialize loop counter
LOOP5       NOP                     ;perform no operation
            SUB.L   #1,D0           ;decrement loop counter
            BNE     LOOP5           ;do it again
            
            LEA     MSG5E,A1        ;point to end message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call      
            MOVEM.L (A7)+,A1/D0     ;restore working registers
            RTE                     ;use RTE to return from interrupt
            
* Interrupt service routine 6  
ISR6        ORI.W   #$0700,SR       ;sets priority level to 7
            MOVEM.L A1/D0,-(A7)     ;save working registers
            ANDI.W  #$FEFF,SR       ;set priority level to 6
            LEA     MSG6S,A1        ;point to start message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call
            
            MOVE.L  #$00100000,D0   ;initialize loop counter
LOOP6       NOP                     ;perform no operation
            SUB.L   #1,D0           ;decrement loop counter
            BNE     LOOP6           ;do it again
            
            LEA     MSG6E,A1        ;point to end message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call      
            MOVEM.L (A7)+,A1/D0     ;restore working registers
            RTE                     ;use RTE to return from interrupt
            
            
* Interrupt service routine 7  
ISR7        ORI.W   #$0700,SR       ;sets priority level to 7
            MOVEM.L A1/D0,-(A7)     ;save working registers
            ANDI.W  #$FFFF,SR       ;set priority level to 7
            LEA     MSG7S,A1        ;point to start message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call
            
            MOVE.L  #$00100000,D0   ;initialize loop counter
LOOP7       NOP                     ;perform no operation
            SUB.L   #1,D0           ;decrement loop counter
            BNE     LOOP7           ;do it again
            
            LEA     MSG7E,A1        ;point to end message
            MOVE.B  #13,D0          ;display message on console
            TRAP    #15             ;system call      
            MOVEM.L (A7)+,A1/D0     ;restore working registers
            RTE                     ;use RTE to return from interrupt

              
                           
* Starts and ends messages for IQR 1 to IQR 7 
MSG1S       DC.B    'IRQ1 - Starts',0
MSG1E       DC.B    'IRQ1 - Ends',0
MSG2S       DC.B    9,'IRQ2 - Starts',0
MSG2E       DC.B    9,'IRQ2 - Ends',0
MSG3S       DC.B    9,9,'IRQ3 - Starts',0
MSG3E       DC.B    9,9,'IRQ3 - Ends',0
MSG4S       DC.B    9,9,9,'IRQ4 - Starts',0
MSG4E       DC.B    9,9,9,'IRQ4 - Ends',0 
MSG5S       DC.B    9,9,9,9,'IRQ5 - Starts',0
MSG5E       DC.B    9,9,9,9,'IRQ5 - Ends',0
MSG6S       DC.B    9,9,9,9,9,'IQR6 - Starts',0
MSG6E       DC.B    9,9,9,9,9,'IQR6 - Ends',0
MSG7S       DC.B    9,9,9,9,9,9,'IQR7 - Starts',0
MSG7E       DC.B    9,9,9,9,9,9,'IQR7 - Ends',0            

    END    START        



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
