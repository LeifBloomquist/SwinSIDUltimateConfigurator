; ------------------------------------------------
px	dc.b $00
py	dc.b $00
pa	dc.b $00

prns	
	sta pa
	stx px
	sty py

	;jsr CLRCHN (LB) was causing problems with IDE64
	pla
	sta addr$+1
	pla
	sta addr$+2
loop$	inc addr$+1
	bne addr$
	inc addr$+2
addr$	lda $aaaa
	beq out$
	jsr CHROUT
	jmp loop$
out$	lda addr$+2
	pha
	lda addr$+1
	pha

	lda pa
	ldx px
	ldy py

	rts