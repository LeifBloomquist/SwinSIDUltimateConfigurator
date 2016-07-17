	processor 6502
	org $0801

	; SwimSID Ultimate Configurator Tool
	; Schema / AIC

	include "macros.asm"	

BASIC ;6 sys 2064
	dc.b $0c,$08,$06,$00,$9e,$20,$32,$30
	dc.b $36,$34,$00,$00,$00,$00,$00

START	SUBROUTINE
  lda #$00
  sta $d020
  sta $d021
  jsr MENUSCREEN
    
CHECKKEYS 
  jsr $ffe4
  
  cmp #$4E    ; N
  bne MENUSCREEN
  jmp CHECKKEYS

;kg  
;  cmp #$47    ; G
;  bne kl  
;  jmp GETNEWGW 
;
;kl
;  cmp #$4C    ; L
;  bne ks 
;  jmp SETLANMODE
;  
;ks  
;  cmp #$53    ; S
;  bne CHECKKEYS  
;  jmp GETNEWSERVER
  

;---------------------------------------------------------------
MENUSCREEN

  PRINT CG_CLR,CG_DCS, CG_LCS, CG_YEL,"sWIN",CG_RED,"sid ", CG_LBL, "uLTIMATE ", CG_BLU, "cONFIGURATOR",CRLF,CRLF
  
  PRINT "sid tYPE: 6581   / 8580", CRLF
  PRINT "pITCH:    ntsc   / pal", CRLF
  PRINT "aUDIO iN: aLLOW  / dISABLE  ", CRLF
  PRINT "sAMPLING: eNABLE / fINISHED (Requires Re-Init)", CRLF
  PRINT "led mODE: nOTE   / iNVERTED / rw", CRLF, CRLF
  
  PRINT "* rEQUIRES rE-iNIT", CRLF, CRLF
  
  PRINT "rE-iNIT cHIP"
  PRINT "sET dEFAULTS"

   ; To-Do; Enter WaveTable  
  
  rts




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