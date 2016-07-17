;kernal routines
ACPTR  = $ffa5
CHKIN  = $ffc6
CHKOUT = $ffc9
CHRIN  = $ffcf
CHROUT = $ffd2
CIOUT  = $ffa8
CLOSE  = $ffc3
GETIN  = $ffe4
CLALL  = $ffe7
CLRCHN = $ffcc
LISTEN = $ffb1
OPEN   = $ffc0
SECOND = $ff93
SETLFS = $ffba
SETNAM = $ffbd
TALK   = $ffb4
TKSA   = $ff96
UNLSN  = $ffae
UNTLK  = $ffab
STOP   = $ffe1
READST = $ffb7
LOAD   = $ffd5
SAVE   = $ffd8

;zeropage addresses
DHCP_PTR = $55 ;(2)
RECV_PTR = $57 ;(2)
XMIT_PTR = $59 ;(2)
RECV_LEN = $5b ;(2)
XMIT_LEN = $5d ;(2)
DNS_TMP	 = $5f ;(2)
IPM_TMP  = $61 ;(2)
CPY_SRC  = $63 ;(2)
CPY_DST  = $65 ;(2)
SAV_PTR  = $67 ;(2)

;utils zeropage
INPUT_PTR = $67 ;(2)
INPUT_Y	  = $69 ;(1)

;checksum zeropage
MakeChecksumZp_Ptr = $6a ;(2)

;c64 c/g 
CG_BLK = 144
CG_WHT = 5
CG_RED = 28
CG_CYN = 159
CG_PUR = 156
CG_GRN = 30
CG_BLU = 31
CG_YEL = 158
CG_BRN = 149
CG_ORG = 129
CG_PNK = 150
CG_GR1 = 151
CG_GR2 = 152
CG_LGN = 153
CG_LBL = 154
CG_GR3 = 155
CG_RVS = 18 ;revs-on
CG_NRM = 146 ;revs-off

CG_DCS = 8  ;disable shift+C=
CG_ECS = 9  ;enable shift+C=

CG_LCS = 14 ;switch to lowercase
CG_UCS = 142 ;switch to uppercase

CG_CLR = 147 ;clear screen

;cursor movement
CS_HOM = 19
CS_U   = 145
CS_D   = 17
CS_L   = 157
CS_R   = 29

CRLF   = 13

YN_NO     = 0
YN_YES    = 1
YN_CANCEL = 2
