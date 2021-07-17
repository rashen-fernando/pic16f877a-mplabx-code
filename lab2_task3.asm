processor 16f84a		;name of the processor
    #include <p16f84a.inc>	;include the processor
    
    org 0x00			;set origin vector to 0
    
    STATUS equ 03h		;assign name STATUS to 03h register
    TRISA equ 85h		;assign name TRISA to 85h register
    TRISB equ 86h		;assign name TRISB to 86h register
    PORTA equ 05h		;assign name PORTA to 05h register
    PORTB equ 06h		;assign name PORTB to 06h register
    INTCON equ 0Bh		;assign name INTCON to 0Bh register
    count1 equ 10h		;assign name count1 to 10h register
    count2 equ 11h		;assign name count2 to 11h register
    count3 equ 12h		;assign name count3 to 12h register
    count4 equ 13h		;assign name count4 to 13h register
    num1 equ 14h		;assign name num1 to 14h register
    num2 equ 15h		;assign name num2 to 15h register
    pattern equ 16h		;assign name pattern to 16h register
 
    goto start
 
     ;######Delay1 subroutine will cause a delay of 0.78s#####;
 delay1				;delay subroutine 1
    movlw 0xFF			;move value FFh to W
    movwf 10h			;move value in W to register 10h , count1=255
    movwf 11h			;move value in W to register 11h , count2=255
    loop1 decfsz count1,1	;decrease value of count1 by 1
	goto loop1		;if count1 value not equal to 0 goto loop1
	decfsz count2,1		;decrease value of count2 by 1
	goto loop1		;if value of count2 not equal to 0 goto loop1
return				;end of delay subroutine 1
	
	
	;#######Delay2 subroutine will cause a delay of 0.22s##########;
delay2				;delay subroutine 2
	movlw b'01000111'	;move value 01000111b to W
	movwf 12h		;move value in W to register 12h , count3=71
	movwf 13h		;move value in W to register 13h , count4=71
	loop2 decfsz count3,1	;decrease value of count3 by 1	
	      goto loop2	;if count3 value not equal to 0 goto loop2
	      decfsz count4,1	;decrease value of count4 by 1
	      goto loop2	;if count4 value not equal to 0 goto loop2
return				;end of delay subroutine 2

	  
	;###########   COMPARING   ################;
comp 
	sublw b'00000101'	;substract value in W from 5 , (5-w)
	BTFSS STATUS,0		;check the C bit to identify if num1 is smaller or equal; or larger than 5
	goto larger		;since C bit of status register is 0, it means W>5
	BTFSS STATUS,2		;check the Z bit of status register to identify if num1 if smaller or equal to 5
	goto smaller		;since Z bit of status register is 0, it means W<5
	goto equal		;since Z bti of status register is 1, it means W=5
	
	larger 
	    movlw b'00000010'	;assign bit pattern to W
	    movwf pattern	;move value in W to pattern register
	    return
	    
	smaller
	    movlw b'00000001'	;assign bit pttern to W
	    movwf pattern	;move value in W to pattern register
	    return
	  
	equal
	    movlw b'00000001'	;assign bit pattern to W
	    movwf pattern	;move value in W to pattern register
	    return
	    

;******************MAIN PROGRAM*******************;	    
	    
start
	bcf STATUS,5		;go to bank 0
	CLRF PORTB		;clear all bits of port B pins
	bsf STATUS,5		;go to bank 1
	movlw 00h		;make W 00h
	movwf TRISB		;make all ports of B as outputs
	bcf STATUS,5		;go to bank 0
	
	movlw b'00000000'	;assign 0 to w
	movwf num1		;make num1 as 0
	movlw b'00000111'	;assign 7 to w
	movwf num2		;make num2 as 7
	
	movf num1,0		;get num1 to w
	call comp		;call subroutine to compare num1
	movwf PORTB		;move pattern to port B pins
	call delay1		;as the delay is 2s from my E number have to call each delay function twice
	call delay1
	call delay2
	call delay2 

	movf num2,0		;get num2 to w
	call comp		;call subroutine to compare num2
	swapf pattern,0		;swap the bit pattern to get the correct output for num2
	movwf PORTB		;move pattern to port B pins
	call delay1		;as the delay is 2s from my E number have to call each delay function twice
	call delay1
	call delay2
	call delay2 
	
	goto start		;as the pattern should appear again and again the program is run continuously

end