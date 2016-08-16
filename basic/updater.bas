100 s=54272
110 poke53281,0 :rem background black
120 ?"{white}{142}":rem white uppercase
130 ?"{clear}{home}"
140 ?" swinsid ultimate firmware updater v1.0 "
150 ?" -------------------------------------- "
160 ?:?
170 res$=chr$(peek(s+27))+chr$(peek(s+28))
180 if res$="ur" then ?"unbricking swinsid ultimate":goto 480
190 poke s+29,asc("s"):poke s+30,asc("i"):poke s+31,asc("d")
200 swid$=chr$(peek(s+27))+chr$(peek(s+28))
210 poke s+31,asc("e")
220 swid$=swid$+chr$(peek(s+27))+chr$(peek(s+28))
230 ? swid$
240 if swid$<>"swin" then ?"no swinsid ultimate detected":stop
250 poke s+31,asc("v")
260 v1$=chr$(peek(s+27)):v2$=chr$(peek(s+28))
270 ? v1$;v2$
280 if v1$<>"u" then ?"mo supported swinsid ultimate detected":stop
290 if v2$<"4" then ?"swinsid ultimate is not compatible":stop
300 ?:?"enter the update filename"
310 input fw$
320 if fw$="" then goto 300
330 rem fw$="0:"+fw$+",s,r"
340 ?:?:?
350 open 15,8,15
360 gosub 59990
370 open 1,8,3,fw$
380 gosub 59990
390 poke s+29,asc("s"):poke s+30,asc("x"):poke s+31,asc("f")
400 res$=chr$(peek(s+27))+chr$(peek(s+28))
410 if res$<>"bl" then ?"bootloader is not responding":stop
420 poke s+13,asc("m"):poke s+30,asc("A"):poke s+1,asc("r")
430 poke s+21,asc("C"):poke s,asc("0")
440 for n=1 to 1000:next n:rem delay
450 res$=chr$(peek(s+27))+chr$(peek(s+28))
460 if res$<>"ur" then ?"updater code is not ready: ";res$:stop
470 goto 570
480 ?:?"enter the update filename"
490 input fw$
500 if fw$="" then goto 480
510 rem fw$="0:"+fw$+",s,r"
520 ?:?
530 open 15,8,15
540 gosub 59990
550 open 1,8,3,fw$
560 gosub 59990
570 for j=0 to 110
580 for i=0 to 42
590 get#1,a$,b$,c$
600 gosub 59990
602 if a$="" then a$=chr$(0)
604 if b$="" then b$=chr$(0)
606 if c$="" then c$=chr$(0)
610 a=asc(a$):b=asc(b$):c=asc(c$)
620 a1=int(a/16):a2=a-(a1*16)
630 poke s+a1,b:poke s+a2,c
640 next i
650 get#1,c1$,c2$
660 gosub 59990
665 if c1$="" then c1$=chr$(0)
668 if c2$="" then c2$=chr$(0)
670 c1=asc(c1$):c2=asc(c2$)
680 rch=peek(s+27)*256+peek(s+28)
690 ch=c1*256+c2
700 if ch<>rch then ?"page check error ";rch;ch:stop
710 poke s+29,15
720 for n=1 to 700:next n:rem delay
730 res$=chr$(peek(s+27))+chr$(peek(s+28))
740 if res$<>"ok" then ?"page write failed":stop
750 ? "{up}page ";j;"/110 done"
760 next j
770 for i=0 to 42
780 get#1,a$,b$,c$ 
790 gosub 59990
792 if a$="" then a$=chr$(0)
794 if b$="" then b$=chr$(0)
796 if c$="" then c$=chr$(0) 
800 a=asc(a$):b=asc(b$):c=asc(c$)
810 a1=int(a/16):a2=a-(a1*16)
820 poke s+a1,b:poke s+a2,c
830 next i
840 get#1,c1$,c2$
850 gosub 59990
852 if c1$="" then c1$=chr$(0)
856 if c2$="" then c2$=chr$(0)
860 c1=asc(c1$):c2=asc(c2$)
870 rch=peek(s+27)*256+peek(s+28)
880 ch=c1*256+c2
890 if ch<>rch then ?"page check error ";rch;ch:stop
900 poke s+29,143
910 for n=1 to 1000:next n:rem delay
920 res$=chr$(peek(s+27))+chr$(peek(s+28))
930 if res$<>"w?" then ?"wrong response":stop
940 get#1,c1$,c2$
950 gosub 59990
955 if c1$="" then c1$=chr$(0)
958 if c2$="" then c2$=chr$(0)
960 c1=asc(c1$):c2=asc(c2$)
970 poke s+25,c2:poke s+26,c1
980 close 1:close 15
990 res$=chr$(peek(s+27))+chr$(peek(s+28))
1000 if res$<>"r?" then ?"wrong response":stop
1010 poke s+22,asc("p"):poke s+7,asc("0"):poke s+11,asc("l"):poke s+28,asc("O")
1020 for n=1 to 10000:next n:rem delay
1030 ?"update finished sucessfully":?"new version:"
1040 poke s+29,asc("s"):poke s+30,asc("i"):poke s+31,asc("d")
1050 swid$=chr$(peek(s+27))+chr$(peek(s+28))
1060 poke s+31,asc("e")
1070 swid$=swid$+chr$(peek(s+27))+chr$(peek(s+28))
1080 ? swid$
1090 poke s+31,asc("v")
1100 ? chr$(peek(s+27));chr$(peek(s+28))
1110 ?:?"reinit"
1120 poke s+29,asc("s"):poke s+30,asc("e"):poke s+31,asc("t")
1130 end
59990 input#15,en,em$,et,es
60000 if en>1 then ? en;em$;et;es:stop
60010 return