;
;         Vypis pameti na obrazovku
;         =========================
;
;        Naprogramoval: Shrek/MB Maniax
;       Assembler: Odin/ZX Spectrum Next
;                     2021



        ORG $,$2000
start
        LD A,H
        OR L
        CALL Z,nastav_konec
        PUSH HL
        CALL maketab

        POP HL

        CALL vypocitej_adresu2
        LD (adresa_arg),HL
        LD HL,$4000
        LD DE,$4001
        LD BC,$17ff
        XOR A
        LD (HL),A
        LDIR
        CALL iniroll

warm_reset
        LD HL,2*256
        LD (X4b),HL
        LD HL,0
        CALL pozice

        LD HL,title
        CALL print
;       OPT pause
        CALL enter

;        LD HL,podtrh
;        CALL print

;        CALL enter
        LD HL,empty
        CALL print
        CALL enter

        LD A,(konec)
        OR A
        JP NZ,noargs

        LD HL,(adresa_arg)
        CALL adresa
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        CALL adresa1
        LD H,0
        LD L,21
        CALL pozice
;        LD HL,bottom
;        CALL print
        JP loop0

horni_adr DEFW 0
dolni_adr DEFW 0

jetext    DEFB 0

font4     DEFB 0


loop4b  PUSH HL
        LD HL,tabvram + 16
        LD B,192-16

cisti
        PUSH BC
        PUSH HL
        LD A,(HL)
        INC HL
        LD H,(HL)
        LD L,A
        LD E,L
        LD D,H
        INC DE
        XOR A
        LD (HL),A
        LD BC,31
        LDIR

        POP HL
        POP BC
        LD DE,2
        ADD HL,DE
        DJNZ cisti

        LD HL,22528+32*2
        LD DE,22529+32*2
        LD BC,32
        LD A,%00111000
        LD (HL),A
        LDIR

        LD A,(soustava)
        CP 16

        POP HL
loop4a
        PUSH HL

        CALL print_number

        LD HL,(X4b)
        LD A,":"
        CALL CHAR4b
        LD HL,X4b
        INC (HL)
        LD A," "
        LD HL,(X4b)
        CALL CHAR4b
        LD HL,X4b
        INC (HL)

        POP HL
        LD A,(jetext)
        CP "t"
        JP Z,text_mode4
        PUSH HL
pocb    LD B,16
pocet_bytu4
        PUSH BC
        PUSH HL
        LD A,(HL)
        LD L,A
        LD H,0
        CALL decimal3
        LD HL,X4b
        LD A,(soustava)
        CP 16
        JR NZ,bbb

        LD A,(pocitadlo)
        OR A
        JR Z,bez_mezery
        INC (HL)
        LD A,255
        LD (pocitadlo),A

bez_mezery
        LD HL,pocitadlo
bbb     INC (HL)

        POP HL
        INC HL
        POP BC
        DJNZ pocet_bytu4

        LD HL,X4b
        INC (HL)

        POP HL
        LD A,(pocb+1)
        LD B,A

pocet_bytu5
        PUSH BC
        PUSH HL
        LD A,(HL)
        CP 32
        JR C,tecka4
        CP "z"
        JR NC,tecka4
        JR netecka4

tecka4  LD A,"."
netecka4
        LD HL,(X4b)
        CALL CHAR4b
        LD HL,X4b
        INC (HL)
        POP HL

        POP BC

        INC HL
        DJNZ pocet_bytu5


        PUSH HL
        LD HL,X4b+1             ;ENTER
        INC (HL)
        XOR A
        LD (X4b),A

        POP HL
        RET

podbarvi
        LD HL,22528+32*2
        LD B,19
pod0
        PUSH BC

        LD HL,attr16

pod     LD DE,22528+32*2
        LD BC,19
        LDIR

        POP BC
        LD HL,(pod+1)
        LD DE,32
        ADD HL,DE
        LD (pod+1),HL
        DJNZ pod0
        RET

pocitadlo NOP
attr16
        DB %00111000
        DB %00111000
        DB %00111000
        DB %01111000,%00111000
        DB %01111000,%00111000
        DB %01111000,%00111000
        DB %01111000,%00111000
        DB %01111000,%00111000
        DB %01111000,%00111000
        DB %01111000,%00111000
        DB %01111000,%00111000

adresa
        LD HL,22528+32*2
        LD DE,22529+32*2
        LD A,%00111000
        LD BC,32
        LD (HL),A
        LDIR

        LD HL,(adresa_arg)

        LD A,(font4)
        OR A
        JP NZ,loop4b
adresa1
        LD A,(font4)
        OR A
        JP NZ,loop4a
loop
        PUSH HL
        CALL print_number
        LD A,"|"
        CALL print_char
        POP HL

        LD A,(jetext)
        CP "t"
        JP Z,text_mode

        PUSH HL
        LD B,5                  ;pocet adres na radek

loop_radek
        PUSH BC
        LD A,(HL)               ;v reg A se nachazi hodnota
        PUSH HL
        LD L,A
        LD H,0
        CALL decimal3             ;vytiskni obsah pameti
        LD A,32
        CALL print_char         ;vytiskni mezeru mezi cisly
        POP HL
        POP BC
        INC HL
        DJNZ loop_radek

        POP HL                  ;obnovime pocatek vypisu a vypiseme znaky
        LD B,5

loop_znaky
        LD A,(HL)
        CP 32
        JR C,tecka

        CP "z"
        JR NC,tecka
        JR netecka

tecka   LD A,"."                ;zastupny symbol pro netisknutellne znaky
netecka
        PUSH HL
        CALL print_char
        POP HL
        INC HL
        DJNZ loop_znaky


        PUSH HL
        LD A,(jetext)
        CP "t"
        JR Z,nemez
        LD A,(Y)
        OR A

        LD A,32
        CALL NZ,print_char
nemez
        CALL enter

        POP HL
        RET
text_mode4
        LD B,57
        JP pocet_bytu5

text_mode
        LD B,26
        JP loop_znaky

loop0
        CALL inkey

        CP 10
        JP Z,nahoru

        CP 11
        JP Z,dolu

        CP "h"
        JP Z,hexa

        CP 9
        JP Z,leva

        CP 8
        JP Z,prava

        CP "d"
        JP Z,deca

        CP 13
        JP Z,show_help

        CP 32
        JP Z,change_font

        CP "m"
        JP Z,memory

        CP "t"
        JP Z,to_text_mode

        CP   "q"
        RET Z
        JR loop0

memory
        HALT
        HALT
        HALT
        HALT

        LD A,32
        LD (v1+1),A
        LD A,24
        LD (v2+1),A
        LD (v3+1),A

        CALL menu

        LD A,130
        LD (v1+1),A
        LD A,122
        LD (v2+1),A
        LD (v3+1),A


        LD HL,16*256+6
        CALL pozice
        LD HL,memory_txt
        CALL print

        LD IXH,10
        LD HL,32*256+6
        LD A,4
        LD (bh+1),A
        CALL INPUT
        LD A,1
        LD (bh+1),A
        LD HL,23296
        CALL vypocitej_adresu2
        LD (adresa_arg),HL
        JP warm_reset

to_text_mode
        LD (jetext),A
        JP warm_reset

change_font
        LD A,(font4)
        XOR 1
        LD (font4),A
        LD A,(soustava)
        CP 10
        JR Z,nastav104
        CP 16
        JR Z,nastav164
        JP warm_reset
nastav164
        LD A,16
nnn     LD (pocb+1),A
        JP warm_reset
nastav104
        LD A,10
        JR nnn

show_help
        CALL menu
        LD HL,16*256+6
        CALL pozice

        LD HL,title_help
        CALL print

        LD HL,32 * 256 + 6
        CALL pozice
        LD HL,con1
        CALL print

        LD HL,40 * 256 + 06
        CALL pozice
        LD HL,con4
        CALL print

        LD HL,48*256+6
        CALL pozice
        LD HL,con9
        CALL print


        LD HL,64 * 256 + 6
        CALL pozice
        LD HL,con3
        CALL print

        LD HL,72 * 256 + 6
        CALL pozice
        LD HL,con2
        CALL print

        LD HL,80*256+6
        CALL pozice
        LD HL,con8
        CALL print

        LD HL,88*256+6
        CALL pozice
        LD HL,con7
        CALL print

        LD HL,96*256+6
        CALL pozice
        LD HL,con10
        CALL print


        LD HL,112 * 256 + 6
        CALL pozice
        LD HL,con5
        CALL print

        LD HL,128 * 256 + 6
        CALL pozice
        LD HL,con6
        CALL print


        CALL inkey
        LD HL,22528 + 32*2
        LD DE,22529 + 32*2
        LD A,%00111111
        LD (HL),A
        LD BC,31
        LDIR


        JP warm_reset

leva    LD HL,(adresa_arg)
        LD DE,256
        ADD HL,DE
        LD (adresa_arg),HL
        JP warm_reset

prava
        LD HL,(adresa_arg)
        LD DE,256
        OR A
        SBC HL,DE
        LD (adresa_arg),HL
        JP warm_reset

hexa
        LD (jetext),A
        LD A,16
        LD (soustava),A
        LD A,16
        LD (pocb+1),A
        JP warm_reset

deca    LD (jetext),A
        LD A,10
        LD (soustava),A
        LD A,10
        LD (pocb+1),A
        JP warm_reset

soustava
        DEFB 10

nastav_konec
        LD A,1
        LD (konec),A
        RET

konec   DEFB 0

nahoru
        CALL rollup
        LD HL,22*256
        LD (X4b),HL
        LD HL,176*256+0
        CALL pozice
        LD HL,(adresa_arg)
        CALL narustek
        ADD HL,DE
        LD (adresa_arg),HL

patch                            ;patch od ub880d - chyba listovani smerem
        LD A,(font4)             ;nahoru
        OR A
        JR NZ,patch_condensed
        LD A,(jetext)
        LD DE,520
        CP "t"
        JR Z,patch_finish
        LD DE,100
        JR patch_finish

patch_condensed
        LD A,(jetext)
        LD DE,1160
        CP "t"
        JR Z,patch_finish
        LD DE,200
        CP "d"
        JR Z,patch_finish
        LD DE,320

patch_finish
        ADD HL,DE
        CALL adresa1
        JP loop0

dolu
        CALL rolldown
        LD HL,2*256
        LD (X4b),HL
        LD HL,16*256+0
        CALL pozice
        LD HL,(adresa_arg)
        CALL narustek
        OR A
        SBC HL,DE
        LD (adresa_arg),HL
        CALL adresa1
        JP loop0

;vrati v de
narustek
        LD A,(font4)
        OR A
        JR NZ,narustek4
        ;8bitovy font
        LD A,(jetext)
        LD DE,26
        CP "t"
        RET Z

        LD DE,5
        RET


narustek4
        LD A,(jetext)
        CP "t"
        LD DE,58
        RET Z
        LD A,(soustava)
        LD E,A
        LD D,0
        RET

cekej   XOR A
        IN A,(254)
        CPL
        AND 31
        JR Z,cekej

        RET

noargs  CALL enter
        LD HL,help
        CALL print
        CALL enter
        LD HL,help1
        CALL print
        CALL enter
        LD HL,help11
        CALL print
        CALL enter
        LD HL,help12
        CALL print
        CALL enter
        LD HL,help13
        CALL print


        CALL enter
        CALL enter
        LD HL,help2
        CALL print
        RET

maketab
        PUSH IX
        LD HL,16384
        LD IX,tabvram
        LD B,192

maketab2
        LD (IX+0),L
        INC IX
        LD (IX+0),H
        INC IX

        CALL downhl
        DJNZ maketab2
        POP IX
        RET

print   LD A,(HL)
        OR A
        RET Z
        CALL print_char
        INC HL
        JR print

        INCLUDE "print_number.odn"
        INCLUDE "argument.odn"
        INCLUDE "texty.odn"
        INCLUDE "inkey.odn"
;        INCLUDE "help_menu.odn"
        INCLUDE "print4b.odn"
        INCLUDE "scroll.odn"
        INCLUDE "input.odn"
konec_source
ddd     EQU $-start
        SAVE "/dot/memdump",$8000,$2000

