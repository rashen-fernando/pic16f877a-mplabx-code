	    processor 16f84a
	    #include<p16f84a.inc>
    
	    org 0x00
	    goto Main

Main:
  
	bsf		STATUS,5
	movlw		b'00000000'
	movwf		TRISB
	bcf		STATUS,5
        movlw		b'11111111'
	movwf		PORTB
	goto		$
end
   
    




