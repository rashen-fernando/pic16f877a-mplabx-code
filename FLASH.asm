processor 16f84a
	    #include<p16f84a.inc>
    
	    org 0x00
	    COUNT1 equ 0x20
	    goto Main

Main:
  
	bsf		STATUS,5
	movlw		b'00000000'
	movwf		TRISB
	bcf		STATUS,5
	
	
        start	movlw		b'11111111'
		movwf		PORTB
		call		delay
		movlw		b'00000000'
		movwf		PORTB
		call		delay
		goto		start
		
	delay
	    loop1   decfsz	COUNT1,1
		    goto	loop1
	return
end
   
    




