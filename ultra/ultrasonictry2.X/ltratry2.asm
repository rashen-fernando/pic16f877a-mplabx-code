processor 16f877a
#include<p16f877a.inc>
org 0x00
    
COUNT1	    equ 0x20
COUNT2	    equ	0x21

INTCON equ 0Bh   ;interruopt re;lated
STATUS equ 03h	  
 
T1CON	equ  10h
TMR1L	EQU 0EH
TMR1H	EQU 0FH	
PIE1	EQU 8CH   ;TIMER INTURREPT /BANK 1	
	
TRISD equ 88h
PORTD equ 08h
 
TRISB equ 86h
PORTB equ 06h




    goto Main
    
    ORG	    0x04
	CALL	STARTIMER
	BCF	INTCON,1
    retfie

    
Main:
	
	bsf	    STATUS,5
	bcf	    STATUS,6		;selecting bank 1
	movlw	    b'00000001'		;setting portB ECHO - RB0(IN),TRIGGER - RB1(OUT)
	movwf	    TRISB
	movlw	    b'00000000'		;setting port D as output
	movwf	    TRISD
	BCF	    PIE1,0		;DISABLE TIMER 1 OVERFLOW
	bcf	    STATUS,5		;moving back to bank 0
	call	    timerconfig
	bsf	    INTCON,7
	BSF	    INTCON,4
	BCF	    INTCON,1
	
loop1
	
	
	CLRF T1CON ; Stop Timer1, Internal Clock Source, ; T1 oscillator disabled, prescaler = 1:1
	CLRF TMR1H ; Clear Timer1 High byte register
	CLRF TMR1L ; Clear Timer1 Low byte register
	CALL	TRIGGERSET
	goto	loop1
	
STARTIMER
	btfss	PORTB,0	    ;STARTING THE TIMER IF ECHO IS SET
	goto	$-1
	BSF	T1CON,0 ; Timer1 starts to increment ; The Timer1 interrupt is disabled, do polling on the overflow bit
	goto	CHECKECHO
	RETURN
	
	
CHECKECHO
	BCF	PIR1,0
	btfsc	PORTB,0
	goto	CHECKECHO
	BCF	T1CON,0
	movf	TMR1H,0
	movwf	PORTD
	return
	
	

TRIGGERSET
	BSF	PORTB,1
	CALL	delay
	bcf	PORTB,1
	RETURN
	
	
timerconfig
	
	CLRF T1CON ; Stop Timer1, Internal Clock Source, ; T1 oscillator disabled, prescaler = 1:1
	CLRF TMR1H ; Clear Timer1 High byte register
	CLRF TMR1L ; Clear Timer1 Low byte register
	;CLRF INTCON ; Disable interrupts
	BSF STATUS,0 ; Bank1
	CLRF PIE1 ; Disable peripheral interrupts
	BCF STATUS,0 ; Bank0
	CLRF PIR1 ; Clear peripheral interrupts Flags
	MOVLW 0x30 ; Internal Clock source with 1:8 prescaler
	MOVWF T1CON ; Timer1 is stopped and T1 osc is disabled
	return
	


delay
	MOVLW	    b'00001000'
	MOVWF	    COUNT1
	loop2   decfsz  COUNT1,1
		
		goto loop2
		
	return
	end


;Main:
;	
;	bsf	    STATUS,5
;	bcf	    STATUS,6		;selecting bank 1
;	movlw	    b'00000001'		;setting portB ECHO - RB1(OUT),TRIGGER - RB2(IN)
;	movwf	    TRISB
;	movlw	    b'00000000'		;setting port D as output
;	movwf	    TRISD
;	BCF	    PIE1,0		;DISABLE TIMER 1 OVERFLOW
;	bcf	    STATUS,5		;moving back to bank 0
;	call	    timerconfig
;	
;	
;loop1
;	
;	
;	
;	CALL	TRIGGERSET
;	CALL	STARTIMER
;	
;	goto	loop1
;	
;STARTIMER
;	btfss	PORTB,0	    ;STARTING THE TIMER IF ECHO IS SET
;	goto	$-1
;	BSF	T1CON,0 ; Timer1 starts to increment ; The Timer1 interrupt is disabled, do polling on the overflow bit
;	goto	CHECKECHO
;	RETURN
;	
;	
;CHECKECHO
;	BCF	PIR1,0
;	btfsc	PORTB,0
;	goto	CHECKECHO
;	BCF	T1CON,0
;	movf	TMR1L,0
;	movwf	PORTD
;	return
;	
;	
;
;TRIGGERSET
;	BSF	PORTB,1
;	CALL	delay
;	bcf	PORTB,1
;	RETURN
;	
;	
;timerconfig
;	
;	CLRF T1CON ; Stop Timer1, Internal Clock Source, ; T1 oscillator disabled, prescaler = 1:1
;	CLRF TMR1H ; Clear Timer1 High byte register
;	CLRF TMR1L ; Clear Timer1 Low byte register
;	;CLRF INTCON ; Disable interrupts
;	BSF STATUS,0 ; Bank1
;	CLRF PIE1 ; Disable peripheral interrupts
;	BCF STATUS,0 ; Bank0
;	CLRF PIR1 ; Clear peripheral interrupts Flags
;	MOVLW 0x30 ; Internal Clock source with 1:8 prescaler
;	MOVWF T1CON ; Timer1 is stopped and T1 osc is disabled
;	return
;	
;
;
;delay
;	MOVLW	    b'00001000'
;	MOVWF	    COUNT1
;	loop2   decfsz  COUNT1,1
;		
;		goto loop2
;		
;	return
;	end
;
;
