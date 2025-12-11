BALL_X_VEL  EQU     $15F8               ;Label for accsssing ball horizontal velocity
BALL_Y_VEL  EQU     $15FA               ;Label for accessing ball vertical velocity
            ORG     $1000
            INCBIN  'Pong.BIN'

            ORG     $9000        
START       JMP     $1000
            
            ORG     $8000               ;inserted to allow the ball to bounce off the paddle
        
            MOVE.W  D0,D1              ;moves the paddle offset (0-62), representing the vertical distance in pixles 

            CMP.W   #8,D1              ;compares for an offset from 0-8
            BLE     TOP_ZONE           ;branches if less than or equal to 8 
            CMP.W   #17,D1             ;compares for an offset from 9-17
            BLE     UP_MID1_ZONE       ;branches if less than or equal to 17
            CMP.W   #26,D1             ;compares for an offset from 18-26
            BLE     UP_MID2_ZONE       ;branches if less than or equal to 26
            CMP.W   #35,D1             ;compares for an offset from 27-35
            BLE     CENTER_ZONE        ;branches if less than or equal to 35
            CMP.W   #44,D1             ;compares for an offset from 36-44
            BLE     LO_MID1_ZONE       ;branches if less than or equal to 44 
            CMP.W   #53,D1             ;compares for an offset from 45-53
            BLE     LO_MID2_ZONE       ;branches if less than or equal to 53
            BRA     BOTTOM_ZONE        ;else branches                     
            
TOP_ZONE    MOVE.W  #-3,BALL_Y_VEL     ;updates X velocity 
            BRA   REVERSE_X            ;reverses Y velocity 

UP_MID1_ZONE MOVE.W  #-2,BALL_Y_VEL    ;updates X velocity 
             BRA   REVERSE_X           ;reverses Y velocity 

UP_MID2_ZONE MOVE.W  #-1,BALL_Y_VEL    ;updates X velocity 
             BRA   REVERSE_X           ;reverses Y velocity 

CENTER_ZONE MOVE.W  #0,BALL_Y_VEL      ;updates X velocity 
            BRA   REVERSE_X            ;reverses Y velocity 

LO_MID1_ZONE MOVE.W  #1,BALL_Y_VEL     ;updates X velocity 
             BRA   REVERSE_X           ;reverses Y velocity 

LO_MID2_ZONE MOVE.W  #2,BALL_Y_VEL     ;updates X velocity 
             BRA   REVERSE_X           ;reverses Y velocity 

BOTTOM_ZONE MOVE.W  #3,BALL_Y_VEL      ;updates X velocity
             BRA    REVERSE_X          ;reverses Y velocity

REVERSE_X NEG.W   BALL_X_VEL           ;flips sign of X velocity
  
            RTS                     ;Leave this instruction
            END START



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
