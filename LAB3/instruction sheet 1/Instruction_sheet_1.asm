    processor 16f877a
    #include<p16f877a.inc>
    org 0x00
    
COUNT1  equ 0x20
    goto Main
Main:
	bsf	    STATUS,5
	bcf	    STATUS,6		;selecting bank 1
	movlw	    b'00000000'		;setting port d as output
	movwf	    TRISD
	movlw	    b'11111'		;setting port A as input
	movwf	    TRISA
	bcf	    STATUS,5		;moving back to bank 0
	clrf	    ADCON1		
	bsf	    ADCON1,3		;configure pins in port A to 1000
	bsf	    ADCON1,7
	movlw	    b'11000001'		;set A/D coversion on,set clock to Focs8
	movwf	    ADCON0
	
loop1
	bsf	    ADCON0,3		;setting RA1 as input channel
	call	    adc
	bcf	    ADCON0,3		;setting R0 as input
	call	    adc
	goto	    loop1
    
adc
	call		delay
	bsf		ADCON0,2	;starting the a/d onversion 
wait    
	btfsc	    ADCON1,2	;when conv over ,goes to adresh
	goto	    wait
	movf	    ADRESL,0	;move adresh to portd
	movwf	    PORTD
	call	    delay
	clrf	    PORTD
	return
		
		
delay
loop2   
	decfsz	COUNT1,1
	goto	loop2
	return
	end
		
	


