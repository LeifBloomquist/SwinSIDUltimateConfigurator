	processor 6502
	org $0801

	; SwinSID Ultimate Configurator Tool
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
  PRINT CG_CLR
  jsr MENUSCREEN  
    
CHECKKEYS 
  jsr SHOWSETTINGS
  
wait
  jsr GETIN
  beq wait
  
  sta $c000  ;Debug
  
  ; Check for special keys

f3
  cmp #$86    ; F3
  bne f5
  jsr WAVETABLES
  jmp CHECKKEYS

f5  
  cmp #$87    ; F5
  bne f7
  jmp START
  
f7  
  cmp #$88    ; F7
  bne back
  jsr SETDEFAULTS
  jmp CHECKKEYS

back  
  cmp #$5F    ; Back-Arrow
  bne reset
  jmp EXIT    ; Note jmp for return to BASIC by rts
  
reset
   cmp #'T     ; Handle reset specially, don't re-draw settings (interrupts beep)
   bne zero
   jsr SENDCOMMAND
   jmp wait
   
zero
   cmp #'0    
   bne one
   jsr MUTE0
   jmp CHECKKEYS
   
one
   cmp #'1    
   bne two
   jsr MUTE1
   jmp CHECKKEYS
   
two
   cmp #'2    
   bne three
   jsr MUTE2
   jmp CHECKKEYS

three
   cmp #'3    
   bne four
   jsr MUTE3
   jmp CHECKKEYS

four
   cmp #'4    
   bne others
   jsr MUTE4
   jmp CHECKKEYS
  
; All others, pass-through as a command and keep checking
others  
  jsr SENDCOMMAND
  jmp CHECKKEYS


;---------------------------------------------------------------
SETDEFAULTS
  lda #'8  
  jsr SENDCOMMAND
  jsr DELAY
  
  lda #'D  
  jsr SENDCOMMAND
  jsr DELAY
  
  lda #'F  
  jsr SENDCOMMAND
  jsr DELAY  
    
  lda #'N
  jsr SENDCOMMAND
  jsr DELAY
  
  lda #'L  
  jsr SENDCOMMAND
  jsr DELAY

  lda #'B  
  jsr SENDCOMMAND
  jsr DELAY
  
  lda #$00  
  jsr SETMUTE
  jsr DELAY
  
  rts 
 
;---------------------------------------------------------------
; Command as ASCII value in A
SENDCOMMAND
  ldx #83 ; S
  ldy #69 ; E
  stx SID+29
  sty SID+30
  sta SID+31 
  rts

;---------------------------------------------------------------
; Read Config Parameter as ASCII value in A
; Result stored to config
READCONFIG
  ldx #83 ; S
  ldy #73 ; I
  stx SID+29
  sty SID+30
  sta SID+31

  jsr DELAY
  
  ldx SID+27
  ldy SID+28
  stx config
  sty config+1
     
  rts
  
config
  .byte 00, 00
  
;---------------------------------------------------------------
; Set Mute Bitmask, in A
SETMUTE
  sta SID+31  ; Do this first!
  sta mute_shadow
  
  ldx #$FF     ; Clear config
  stx SID+29
  stx SID+30
  jsr DELAY
   
  ldx #83 ; S
  ldy #77 ; M
  stx SID+29
  sty SID+30
  jsr DELAY 
  rts
  
mute_shadow
  .byte 00
  
;---------------------------------------------------------------
; Muting various channels 
MUTE0  ; None
   lda #$00
   jsr SETMUTE
   rts

MUTE1  ; Voice 1
   lda mute_shadow
   ora #%00000001
   jsr SETMUTE
   rts

MUTE2  ; Voice 2
   lda mute_shadow
   ora #%00000010
   jsr SETMUTE
   rts

MUTE3  ; Voice 4
   lda mute_shadow
   ora #%00000100
   jsr SETMUTE
   rts  
   
MUTE4  ; Digis
   lda mute_shadow
   ora #%00001000
   jsr SETMUTE
   rts    

;---------------------------------------------------------------
; To-Do: Enter Custom WaveTable
WAVETABLES
   rts

;---------------------------------------------------------------
; Read+Print Config Parameter as ASCII value in A
; Params stored to config
PRINTCONFIG
  jsr READCONFIG
  lda config
  jsr CHROUT    
  lda config+1
  jsr CHROUT
  rts  
  
;---------------------------------------------------------------
MENUSCREEN 
  jsr SHOWSETTINGS 
  jsr SEPARATOR  
  
  PRINT CG_BLU, "sid tYPE:   ", CG_YEL, "6", CG_LBL, "581   / ", CG_YEL, "8", CG_LBL, "580", CRLF
  PRINT CG_BLU, "pITCH:      ", CG_LBL, "nt", CG_YEL, "s", CG_LBL, "c   / pa", CG_YEL, "l", CRLF
  PRINT CG_BLU, "aUDIO iN:   ", CG_YEL, "a", CG_LBL, "LLOW  / ", CG_YEL, "d", CG_LBL, "ISABLE ", CG_WHT, "*", CRLF
  PRINT CG_BLU, "sAMPLING:   ", CG_YEL, "e", CG_LBL, "NABLE / ", CG_YEL, "f", CG_LBL, "INISHED ", CG_WHT, "*", CRLF
  PRINT CG_BLU, "led mODE:   ", CG_YEL, "n", CG_LBL, "OTE   / ", CG_YEL, "i", CG_LBL, "NVERTED / ", CG_YEL, "r", CG_LBL, "w", CRLF
  PRINT CG_BLU, "sTART bEEP: ", CG_YEL, "b", CG_LBL, "EEP   / ", CG_YEL, "m", CG_LBL, "UTE", CRLF
  PRINT CG_BLU, "mUTE:       ", CG_LBL, "nONE=", CG_YEL, "0", CG_LBL, " / ", CG_YEL, "1", CG_LBL, " / ", CG_YEL, "2", CG_LBL, " / ", CG_YEL, "3", CG_LBL, " / ", CG_YEL, "4", CG_LBL, "=dIGI", CRLF
  PRINT CG_BLU, "            ", CG_LBL, "rE-iNI", CG_YEL,"t", CG_LBL, " cHIP", CRLF
  PRINT CG_WHT, "            *", CG_GR2, " rEQUIRES rE-iNIT", CRLF, CRLF

  PRINT CG_GR1, "            f3", CG_GR1, " lOAD wAVETABLE (FUTURE)", CRLF
  PRINT CG_YEL, "            f5", CG_LBL, " rEFRESH", CRLF
  PRINT CG_YEL, "            f7", CG_LBL, " sET dEFAULTS", CRLF  
  PRINT CG_YEL, "            ", $5F ,CG_LBL, "  eXIT pROGRAM", CRLF
   
  jsr SEPARATOR     
         
  PRINT CRLF, CG_LGN, "                             sCHEMA/aic", CS_HOM
  rts
  
  
;---------------------------------------------------------------
SHOWSETTINGS
  PRINT CS_HOM,CG_DCS, CG_LCS, CG_PNK, "sWIN",CG_YEL, "sid ", CG_WHT, "uLTIMATE ", CG_LBL, "cONFIGURATOR ", CG_LGN, "0.1", CRLF, CRLF
    
  jsr SEPARATOR
  PRINT CG_RED, "iDENTIFICATION: ", CG_PNK
  lda #'D
  jsr PRINTCONFIG
  lda #'E
  jsr PRINTCONFIG
  
  PRINT CG_RED, "  vERSION:    ", CG_PNK
  lda #'V
  jsr PRINTCONFIG   
  PRINT CRLF
  
  PRINT CG_RED, "fUNCTION aS:    ", CG_PNK
  lda #'F
  jsr PRINTCONFIG                    
  
  PRINT CG_RED, "    cLOCK:      ", CG_PNK
  lda #'C
  jsr PRINTCONFIG
  PRINT CRLF
  
  PRINT CG_RED, "led cONFIG:     ", CG_PNK
  lda #'L
  jsr PRINTCONFIG
    
  PRINT CG_RED, "    sTART bEEP: ", CG_PNK
  lda #'B
  jsr PRINTCONFIG
  PRINT CRLF 
  
  PRINT CG_RED, "mUTE bITMASK:   ", CG_PNK, "0"
  lda #'M
  jsr READCONFIG  
  ldx config+1
  lda hex,x
  jsr CHROUT  
  
  PRINT CG_RED, "    aUDIO IN:   ", CG_PNK
  lda #'A
  jsr PRINTCONFIG
  PRINT CRLF
  
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
  
  PRINT CG_CLR, CG_UCS, CG_WHT
  rts

;---------------------------------------------------------------
DELAY
  ldx #50
loop
  nop
  dex
  bne loop
  rts

;---------------------------------------------------------------
hex
  .byte "0123456789abcdef"

; ------------------------------------------------
	include "utils.asm"
