
; ==============================================================
; Original by Six
; Additional macros by LB
; ==============================================================

  include "equates.asm"

; ==============================================================
; Macro to position the cursor
; ==============================================================

  MAC PLOT
  ldy #{1}
  ldx #{2}
  clc
  jsr $E50A  ; PLOT 
  ENDM

; ==============================================================
; Macro to print a string
; ==============================================================

  MAC PRINTSTRING
  ldy #>{0}
  lda #<{0}
  jsr $ab1e ; STROUT 	
  ENDM
  
  MAC PRINT
	jsr prns
	dc.b {0},0
	ENDM

; ==============================================================
; Macro to print a byte
; ==============================================================

	MAC PRINTBYTE
  ldx #$00
  ldy #$0a
  lda {0}
  jsr printnum
  ENDM

; ==============================================================
; Macro to print a word (direct)
; ==============================================================

  MAC PRINTWORD
  lda #<{0}
  ldx #>{0}
  ldy #$0a
  jsr printnum
  ENDM

; ==============================================================
; Macro for border color changes (raster time measure) - comment for no debug
; ==============================================================

  MAC BORDER
  ;lda #{1}
  ;sta $d020
  ENDM
  
; ==============================================================
; Macro for saving settings for SwinSID Ultimate
; ==============================================================

  MAC SAVESETTINGS        
  ldx config
  ldy config+1
  stx {0}
  sty {0}+1  
  ENDM
  
  
; ==============================================================
; Macro for changing cursor colors for SwinSID Ultimate
; ==============================================================

   MAC CHECKSELECTED  
   lda {1}
   ldx #{2}
   jsr ISSELECTED
   ENDM

