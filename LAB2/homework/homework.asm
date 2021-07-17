;e/16/103 A-1,B-0,C-3
;wait time = remainder[(1+3)/4]+1
    
processor 16f84a
#include<p16f84a.inc>
org 0x00
   
output	    equ 22h
numberONE   equ 23h
numberTWO   equ 24h
COUNT1	    equ 25h
COUNT2	    equ 26h
    
 
INTCON equ 0Bh
STATUS equ 03h
 
TRISA equ 85h
PORTA equ 05h
 
TRISB equ 86h
PORTB equ 06h
 
    
    goto Main
    
Main:
    ;setting up ports
	
	bsf	STATUS,5
	movlw	b'00000000'
	movwf	TRISB
	bcf	STATUS,5
	
loop1
	movlw	b'00000000'
	movwf	numberONE
	movlw	b'00000101'
	movwf	numberTWO
	call	compare
	
	movf	output,0
	movwf	PORTB
	call	delay
	movlw	b'00000000'
	movwf	PORTB
	
	movlw	b'00000011'
	movwf	numberONE
	call	compare
	
	movf	output,1
	rlf	output,1
	rlf	output,1
	rlf	output,1
	rlf	output,0
	movwf	PORTB
	call	delay
	movlw	b'00000000'
	movwf	PORTB
	
	
	goto	loop1
	  
	
compare
	bcf	STATUS,0
	bcf	STATUS,2
	movf	numberTWO,0
	subwf	numberONE,0
	btfsc	STATUS,2
	call	SEquF
	btfss	STATUS,0
	call	SLargerThanF
	btfsc	STATUS,0
	call	FLargerThanS
	bcf	STATUS,0
	bcf	STATUS,2
	return
	
	
FLargerThanS
	movlw	b'00000010'
	movwf	output
	return
	
SLargerThanF
	movlw	b'00000001'
	movwf	output
	return
	
SEquF
	movlw	b'00000011'
	movwf	output
	return
	
	
	    
delay
	
	loop2   decfsz  COUNT1,1
		goto	 loop2
		decfsz	 COUNT2,1
		goto loop2
	return
	
	    
    end
	    


