processor 16f84a
    #include<p16f84a.inc>
    org 0x00
    COUNT1 equ 20h
    COUNT2 equ 21h
 
    INTCON equ 0Bh
    STATUS equ 03h
 
    TRISA equ 85h
    PORTA equ 05h
 
    TRISB equ 86h
    PORTB equ 06h
 
    TEMP equ 23h
    goto Main
    
    org 0x04
    movwf   TEMP
    call    ledon
    bcf	    INTCON,1
    retfie
    
    Main:
    ;setting up ports
	bsf	INTCON,7
	bsf	INTCON,4
	bcf	INTCON,1
	bsf	STATUS,5
	movlw	b'00000001'
	movwf	TRISB
	movlw	b'00000000'
	movwf	TRISA
	bcf	STATUS,5
	

	loop1
	movf	TEMP,0
	goto	loop1
	  
	    
	    
	ledon
	    movlw	b'00001'
	    movwf	PORTA
	    call	delay
	    call	delay
	    call	ledoff
	    return
	    
	ledoff
	    movlw	b'00000'
	    movwf	PORTA
	    return
	    
	delay
	
	    loop2    decfsz  COUNT1,1
		     goto	 loop2
		     decfsz	 COUNT2,1
		     goto loop2
	return
	    
end
	    


