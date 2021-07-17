;only works for voltage 3.5v and ref voltage 3.5v

 processor 16f877a
    #include<p16f877a.inc>
    org 0x00
    
COUNT1	    equ 0x20
COUNT2	    equ 0x22
TEMP	    equ 0x21 
CHECK	    equ	0x31
numberONE   equ 0x32
numberTWO   equ 0x33

INTCON equ 0Bh
STATUS equ 03h
ADCON0 equ 1Fh
ADCON1	equ 9Fh
 
TRISA equ 85h
PORTA equ 05h
 
TRISD equ 88h
PORTD equ 08h

    goto Main
Main:
	bsf	    STATUS,5
	bcf	    STATUS,6		;selecting bank 1
	movlw	    b'00000000'		;setting port d as output
	movwf	    TRISD
	movlw	    b'10000'		;setting port A as input
	movwf	    TRISA
	bcf	    STATUS,5		;moving back to bank 0
	clrf	    ADCON1		
	bsf	    ADCON1,3		;configure pins in port A to 1000,adfm
	bsf	    ADCON1,7
	movlw	    b'11000001'		;set A/D coversion on,set clock to Focs8
	movwf	    ADCON0

	
loop1
	
	call	    adc
	movlw	    b'00011001'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch1
	bcf	    CHECK,0
	
	movlw	    b'00010110'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch2
	bcf	    CHECK,0
	
	movlw	    b'00010011'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch3
	bcf	    CHECK,0
	
	movlw	    b'00010000'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch4
	bcf	    CHECK,0
	
	movlw	    b'00001101'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch5
	bcf	CHECK,0
	
	movlw	    b'00001001'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch6
	bcf	CHECK,0
	
	movlw	    b'00000110'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch7
	bcf	CHECK,0
	
	movlw	    b'00000011'
	movwf	    numberTWO 
	call	    compare
	btfsc	   CHECK,0
	call	    switch8
	bcf	    CHECK,0
	
	movlw	    b'00000000'
	movwf	    numberTWO 
	call	    compare
	btfsc	    CHECK,0
	call	    switch0
	bcf	   CHECK,0
	
	goto	    loop1
	
	
	
	
adc
	bcf		ADCON0,3	;setting R0 as input
	call		delay
	bsf		ADCON0,2	;starting the a/d onversion 
wait    
	btfsc	    ADCON1,2		;when conv over ,goes to adresh
	goto	    wait
	movf	    ADRESH,0		;move adresh to portd
	movwf	    numberONE   
	return
		
		
delay
loop2   
	decfsz	COUNT1,1
	decfsz	COUNT2,1
	goto	loop2
	
	return
	
	
compare
	clrf	CHECK		    ;CLEAR CHECK
	bcf	STATUS,0
	bcf	STATUS,2
	movf	numberTWO,0
	subwf	numberONE,0
	btfsc	STATUS,2
	bsf	CHECK,0		    ;set 0th bit of check to 1 if no1=no2
	btfss	STATUS,0
	bsf	CHECK,1		    ;set 1st bit of check to 1 if no2>no1
	btfsc	STATUS,0
	bsf	CHECK,0		    ;set 2nd bit of check to 1 if no1>no2
	bcf	STATUS,0
	
	return

	
switch0
	movlw	b'00000000'	;led
	movwf	PORTD
	return
	
switch1				    ;top switch
	movlw	b'00000001'	
	movwf	PORTD
	
	return
	
switch2
	movlw	b'00000010'	;led
	movwf	PORTD
	
	return
	
switch3
	movlw	b'00000100'	;led
	movwf	PORTD
	return
	
switch4
	movlw	b'00001000'	;led
	movwf	PORTD
	return
	
switch5
	movlw	b'00010000'	;led
	movwf	PORTD
	return
	
switch6
	movlw	b'00100000'	;led
	movwf	PORTD
	return
	
switch7
	movlw	b'01000000'	;led
	movwf	PORTD
	return
	
switch8
	movlw	b'10000000'	;led
	movwf	PORTD
	return
	
	end


