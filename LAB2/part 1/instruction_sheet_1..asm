processor 16f84a
    #include<p16f84a.inc>
    org 0x00
    COUNT1 equ 20h
    COUNT2 equ 21h
    STATUS equ 03h
TRISA equ 85h
PORTA equ 05h
 
TRISB equ 86h
PORTB equ 06h
    goto Main
    
    Main:
    ;setting up ports
	bsf	STATUS,5
	movlw	b'00000001'
	movwf	TRISB
	movlw	b'00000000'
	movwf	TRISA
	bcf	STATUS,5
	

	loop1
	    BTFSC   PORTB,0
	    call    ledon
	loop3	
	    BTFSC   PORTB,0
	    goto    loop3
	    goto    loop1
	  
	    
	    
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
	    


