processor 16f84a
    #include<p16f84a.inc>
    org 0x00
    COUNT1 equ 30h
    COUNT2 equ 31h
    COUNTA equ 34h
    COUNTB equ 35h
    INTCON equ 0Bh
    STATUS equ 03h
 
    TRISA equ 85h
    PORTA equ 05h
 
    TRISB equ 86h
    PORTB equ 06h
 
    TEMP equ 20h
    goto Main
    
    org 0x04
	movwf   TEMP
	call    led
	bcf	    INTCON,1
	retfie
    
    Main:
    ;setting up ports
	movlw	b'00000'
	movwf	PORTA
	bsf	INTCON,7
	bsf	INTCON,4
	bcf	INTCON,1
	bsf	STATUS,5
	movlw	b'00000001'
	movwf	TRISB
	movlw	b'00000'
	movwf	TRISA
	bcf	STATUS,5
	movlw	b'01111101'
	movwf	COUNTA
	movlw	b'01100011'
	movwf	COUNTB
	

	loop1
	movf	TEMP,0
	goto	loop1
	  
	    
	    
	led
	    movlw	b'00001'
	    movwf	PORTA
	    call	delay1
	    call	delay2
	    movlw	b'00000'
	    movwf	PORTA
	    
	    return
	    
	
	    
	delay1
	
	    loop2    decfsz  COUNT1,1
		     goto	 loop2
		     decfsz	 COUNT2,1
		     goto loop2
	return
	
	delay2
	
	    loop3    decfsz  COUNTA,1
		     goto	 loop3
		     decfsz	 COUNTB,1
		     goto loop3
	return
	    
end
	    





