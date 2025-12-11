    
            ORG    $1000
_MAIN:                  

            
            jsr     setup_board         ;put digits 1-9 into squares

LOOP        jsr     display_board       ;display board on console
            jsr     get_move            ;player X goes first - get pointer to selected square
            move.b  #'X',(a0)           ;put X in square pointed at by A0
            jsr     display_board       ;update board with new square containing X
            jsr     line                ;check for a winnig line and exit if found
            
            jsr     get_move            ;player Y's turn - get pointer to selected square
            move.b  #'Y',(a0)           ;put Y in square pointed ab by A0
            jsr     display_board       ;update board with new square containing X
            jsr     line                ;check for a winning line and exit if found

            bra     LOOP 

** end of main subroutine


** all subroutines follow below
          
**************************************************************
* setup_board: puts digits 1-9 into the board data structure *   
*                                                            *
*      ENTER: no parameters                                  * 
*       EXIT: no return value(s)                             *
*       Uses: no subroutines                                 *
**************************************************************
setup_board:
            lea     board,a0            ;put address of board in a0
            move.b  #9,d0               ;count 9 squares
            move.b  #'1',d1             ;put ascii code for '1' into d1
L1          move.b  d1,(a0)+            ;save it in the current square
            add.b   #1,d1               ;get next ascii digit
            cmpi.b  #'9',d1             ;repeat for remaining digits
            bls     L1                  
            rts      


*************************************************************
* display_board: show board in top-left corner of console   *   
*                                                           *
*      ENTER: no parameters                                 * 
*       EXIT: no return value(s)                            *
*       Uses: display_row, display_line subroutines         *
*************************************************************                                                                                                                            
display_board:
            
            ;set cursor position in console to (0,0) -- upper left corner
            
            clr.l   d1                  ;COL = 0 (high byte) ROW = 0 (low byte)
            move.b  #11,d0              ;task 11
            trap   #15                  ;call operating system

            ;draw board one line at a time             
            lea     board,a0            ;put address of board in a0 
            jsr     display_row         ;show first row of board
            jsr     display_line        ;show line separator
            jsr     display_row         ;show first row of board
            jsr     display_line        ;show line separator
            jsr     display_row         ;show first row of board
            rts


*************************************************************
* display_row: display 3 squares in curent row on consol    *   
*                                                           *
*      ENTER: A0 contains address of first square in row    * 
*       EXIT: no return value(s)                            *
*       Uses: display_square, display_char subroutines      *
*************************************************************      
display_row:
            move.b  #' ',d1
            jsr     display_char
            jsr     display_square
            move.b  #' ',d1
            jsr     display_char
            move.b  #'|',d1
            jsr     display_char
            move.b  #' ',d1
            jsr     display_char
            jsr     display_square
            move.b  #' ',d1
            jsr     display_char
            move.b  #'|',d1
            jsr     display_char
            move.b  #' ',d1
            jsr     display_char
            jsr     display_square
            jsr     newline  
            rts
            

*************************************************************
* display_line: display separator line on console           *
*                                                           *
*      ENTER: no parameters                                 * 
*       EXIT: no return value(s)                            *
*       Uses: newline, display_char subroutines             *
*************************************************************  
display_line:
            move.b  #'-',d1
            jsr     display_char
            jsr     display_char
            jsr     display_char
            move.b  #'+',d1
            jsr     display_char

            move.b  #'-',d1
            jsr     display_char
            jsr     display_char
            jsr     display_char
            move.b  #'+',d1
            jsr     display_char
            
            move.b  #'-',d1
            jsr     display_char
            jsr     display_char
            jsr     display_char
            
            jsr     newline
            rts


*************************************************************
* newline: send carriage return, linefeed chars to console  *
*                                                           *
*      ENTER: no parameters                                 * 
*       EXIT: no return value(s)                            *
*       Uses: display_char subroutine                       *
*************************************************************  
newline:
            move.b  #$d,d1          ;carriage retrun
            jsr     display_char    ;send to console
            move.b  #$a,d1          ;linefeed
            jsr     display_char    ;send to console
            rts
            
            
*************************************************************
* display_square: display X or Y square on console          *
*                                                           *
*      ENTER: A0 contains address of square                 * 
*       EXIT: A0 incremented to point to next square        *
*       Uses: display_char subroutine                       *
*************************************************************  
display_square:
            move.b  (a0)+,d1        ;get char in square
            jsr     display_char    ;display char
            rts


*************************************************************
* display_char: send ASCII character to console             *
*                                                           *
*      ENTER: character in D1.B                             * 
*       EXIT: no return value(s)                            *
*       Uses: no subroutines, calls OS routines             *
*************************************************************  
display_char:

        movem.l d0/d1,-(sp)         ;save working registers
        move.b  #6,d0               ;task number 6
        trap    #15                 ;call operating system
        movem.l (sp)+,d0/d1         ;restore registers
        rts

    
*************************************************************
* read_char: read key from keyboard with NO echo            *
*                                                           *
*      ENTER: no parameters                                 * 
*       EXIT: ASCII value of key in D1.B                    *
*       Uses: no subroutines, calls OS I/O routines         *
*************************************************************  
read_char:
        
        ;start by turning off keyboard echo
        clr.b   d1                  ;set lower byte to zero
        move.b  #12,d0              ;select task 12
        trap    #15                 ;call OS
        
        ;now read a single ascii character into D1.B
        move.b  #5,d0               ;select task 5  
        trap    #15                 ;call OS
        rts

   
line:
            movem.l  d0/d1/a0,-(sp)   ; save working registers
            lea      board,a0         ; pointer to the board

            ;checks row 1 (offsets 0,1,2)
            move.b   0(a0),d0   ;loads the address of box 0 into D0 
            move.b   1(a0),d1   ;loads the address of box 1 into D1
            cmp.b    d1,d0      ;sees if same charcter is in the box
            bne      row_1     ;if values are not equal move to row1
            move.b   2(a0),d1   ;if values are equal check the last box in the row
            cmp.b    d1,d0      ;sees if same charcter is in the box
            bne      row_1      ;if values are not equal move to row1
            bra      winner     ;if values are equal move to winner

row_1:
            ;check row 1 (offsets 3,4,5)
            move.b   3(a0),d0   ;loads the address of box 3 into D0
            move.b   4(a0),d1   ;loads the address of box 4 into D1
            cmp.b    d1,d0      ;sees if same charcter is in the box
            bne      row_2      ;if values are not equal move to row2    
            move.b   5(a0),d1   ;if values are equal check the last box in the row
            cmp.b    d1,d0      ;sees if same charcter is in the box
            bne      row_2      ;if values are not equal move to row2
            bra      winner     ;if values are equal move to winner

row_2:
            ;check row 2 (offsets 6,7,8)
            move.b   6(a0),d0   ;loads the address of box 6 into D0
            move.b   7(a0),d1   ;loads the address of box 7 into D1
            cmp.b    d1,d0      ;sees if same charcter is in the box
            bne      col_0      ;if values are not equal move to col0 
            move.b   8(a0),d1   ;if values are equal check the last box in the row
            cmp.b    d1,d0      ;sees if same charcter is in the box
            bne      col_0      ;if values are not equal move to col0
            bra      winner     ;if values are equal move to winner

col_0:
            ;check col 0 (offsets 0,3,6) 
            move.b   0(a0),d0
            move.b   3(a0),d1
            cmp.b    d1,d0
            bne      col_1
            move.b   6(a0),d1
            cmp.b    d1,d0
            bne      col_1
            bra      winner

col_1:
            ;check col 1 offsets (1,4,7)
            move.b   1(a0),d0
            move.b   4(a0),d1
            cmp.b    d1,d0
            bne      col_2
            move.b   7(a0),d1
            cmp.b    d1,d0
            bne      col_2
            bra      winner

col_2:
            ;check col 2 offsets (2,5,8)
            move.b   2(a0),d0
            move.b   5(a0),d1
            cmp.b    d1,d0
            bne      diag_0
            move.b   8(a0),d1
            cmp.b    d1,d0
            bne      diag_0
            bra      winner

diag_0:
            ;check diag 0 (offsets 0,4,8)
            move.b   0(a0),d0
            move.b   4(a0),d1
            cmp.b    d1,d0
            bne      diag_1
            move.b   8(a0),d1
            cmp.b    d1,d0
            bne      diag_1
            bra      winner

diag_1:
            ;check diag 1 (offsets 2,4,6)
            move.b   2(a0),d0
            move.b   4(a0),d1
            cmp.b    d1,d0
            bne      no_win
            move.b   6(a0),d1
            cmp.b    d1,d0
            bne      no_win
            bra      winner

no_win:
            movem.l  (sp)+,d0/d1/a0    ;restore original registers
            rts

winner:
            ; display the letter of the winner
            move.b   d0,d1             
            jsr      display_char
            simHALT                   



get_move:
            movem.l  d0/a1,-(sp)      ;save working registers
            lea      board,a1         ;create a pointer to the board

get_move_loop:
            jsr      read_char        ;jumps to the read_char subroutine which stores the input in D1
            
            cmpi.b   #$1B,d1          ;checks if the value entered is escape (ASCII Value Of 1B)
            beq      esc              ;exits if esc is entered
            
            cmpi.b   #'1',d1          ;checks if the value entered is ASCII Value Of 1  
            blt      get_move_loop    ;repeats if the value is less than 1
            
            cmpi.b   #'9',d1          ;checks if the value entered is ASCII Value Of 9  
            bgt      get_move_loop    ;repeats if the value is greater than 9  

            sub.b    #'1',d1          ;converts from ASCII to decimal
            move.b   (a1,d1.w),d0     ;checks the contents of a square using indirect addressing with an index
            
            
            cmpi.b   #'X',d0          ;checks if an X is in the square              
            beq      get_move_loop    ;repeats if the square is occupied with an X
  
            cmpi.b   #'Y',d0          ;checks if a Y is in the square  
            beq      get_move_loop    ;repeats if the square is occupied with a Z     

            
            lea      (a1,d1.w),a0    ;moves a0 back
            movem.l  (sp)+,d0/a1     ;restores old registers 
            rts                      ;returns to the subroutine 

esc:
            simHALT                  ; user pressed ESC -> exit program


* Allocate memory for 3x3 board data strucutre

           org     $A000
board      ds.b    9           
           end    _MAIN        ; last line of source





*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
