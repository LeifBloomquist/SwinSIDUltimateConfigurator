	processor 6502
	org $0801

	; SwimSID Ultimate Configurator Tool
	; Schema / AIC
  
SID = $D400

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
  jsr GETIN
  beq CHECKKEYS
  
  sta $c000  ;Debug
  
  ; Check for special keys
  
  cmp #$5F    ; Back-Arrow
  bne up
  jmp EXIT    ; Note jmp for return to BASIC by rts

up  
  cmp #$5E    ; Up-Arrow
  bne others
  jsr SETDEFAULTS
  
; All others, pass-through as a command and keep checking
others
  
  jsr SENDCOMMAND
  jmp CHECKKEYS


;---------------------------------------------------------------
SETDEFAULTS
  lda #$00 
  jsr SENDCOMMAND
  rts 
 
;---------------------------------------------------------------
SENDCOMMAND
  ldx #83 ; s
  ldy #69 ; i
  stx SID+29
  sty SID+30
  sta SID+31 
  rts

;---------------------------------------------------------------
MENUSCREEN 
  PRINT CG_CLR,CG_DCS, CG_LCS, CG_YEL,"sWIN",CG_RED,"sid ", CG_WHT, "uLTIMATE ", CG_LBL, "cONFIGURATOR ", CG_LGN, "0.1", CRLF, CRLF
  
  jsr SEPARATOR
  
  PRINT CG_BLU, "sid tYPE:   ", CG_YEL, "6", CG_LBL, "581   / ", CG_YEL, "8", CG_LBL, "580", CRLF
  PRINT CG_BLU, "pITCH:      ", CG_YEL, "n", CG_LBL, "tsc   / ", CG_YEL, "p", CG_LBL, "al", CRLF
  PRINT CG_BLU, "aUDIO iN:   ", CG_YEL, "a", CG_LBL, "LLOW  / ", CG_YEL, "d", CG_LBL, "ISABLE ", CG_WHT, "*", CRLF
  PRINT CG_BLU, "sAMPLING:   ", CG_YEL, "e", CG_LBL, "NABLE / ", CG_YEL, "f", CG_LBL, "INISHED ", CG_WHT, "*", CRLF
  PRINT CG_BLU, "led mODE:   ", CG_YEL, "n", CG_LBL, "OTE   / ", CG_YEL, "i", CG_LBL, "NVERTED / ", CG_YEL, "r", CG_LBL, "w", CRLF
  PRINT CG_BLU, "sTART bEEP: ", CG_YEL, "b", CG_LBL, "EEP   / ", CG_YEL, "m", CG_LBL, "UTE", CRLF
  PRINT CG_BLU, "mUTE:       ", CG_LBL, "cHANNEL 1 / 2 / 3 / 4 ", "(dIGI)", CRLF
  PRINT CG_BLU, "            ", CG_LBL, "rE-iNI", CG_YEL,"T", CG_LBL, " cHIP", CRLF
  PRINT CG_YEL, "            ", $5E ,CG_LBL, " sET dEFAULTS", CRLF  
  PRINT CG_YEL, "            ", $5F ,CG_LBL, " eXIT pROGRAM", CRLF
  PRINT CG_WHT, "            *", CG_GR2, " rEQUIRES rE-iNIT", CRLF
  
  ; To-Do: Enter WaveTable
   
  jsr SEPARATOR     
  jsr SHOWSETTINGS    
  
  ; sCHEMA/aic",CRLF,CRLF
  
  rts
  
  
;---------------------------------------------------------------
SHOWSETTINGS
  rts 
  
;---------------------------------------------------------------
SEPARATOR
  PRINT CG_GR1
  PRINT $60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60,$60
  rts

;---------------------------------------------------------------
EXIT
  ldx #$FF
  ldy #$FF
  lda #$FF
  stx SID+29
  sty SID+30
  sta SID+31 
  
  PRINT CG_WHT
  rts

;---------------------------------------------------------------
; Map between keys and command bytes

KEYS
   .byte 00

; ------------------------------------------------
	include "utils.asm"
