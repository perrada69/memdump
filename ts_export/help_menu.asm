

;
;            Vypise menu a napovedu k memdompu
;
;                   Shrek/MB Maniax 2021
;
;
pozice_loga  EQU 16384+64+19+1
attr         EQU 22528 + (32*2) +20
sirka_okna   EQU 20
vyska_okna   EQU 130
menu
        LD HL,49152
        LD DE,16384
        LD BC,6143
;        LDIR

        LD HL,16384+64+19-14
v1      LD B,vyska_okna
smaz_okno
        PUSH BC
        PUSH HL
        LD D,H
        LD E,L
        INC DE
        LD BC,sirka_okna
        XOR A
        LD (HL),A
        LDIR

        POP HL

        CALL downhl
        POP BC
        DJNZ smaz_okno

        LD HL,pozice_loga
        CALL kresli_logo
        LD HL,pozice_loga+1
        CALL kresli_logo
        LD HL,pozice_loga+2
        CALL kresli_logo
        LD HL,pozice_loga+3
        CALL kresli_logo
        LD HL,pozice_loga+4
        CALL kresli_logo
        LD B,sirka_okna+1
        LD HL,attr-15
a5      LD (HL),7
        INC HL
        DJNZ a5

        LD A,%00000010
        LD (attr),A

        LD A,%00010110
        LD (attr+1),A

        LD A,%00110100
        LD (attr+2),A
        LD A,%00100001
        LD (attr+3),A
        LD A,%00001000
        LD (attr+4),A
        CALL window
        RET

window
        LD HL,16384+32+19-14
        LD B,7

w0
        PUSH BC
        CALL downhl
        POP BC
        DJNZ w0
        PUSH HL
        LD B,8
w3      CALL downhl
        DJNZ w3
        LD (zacatek_pozice+1),HL
        POP HL
        PUSH HL
        LD B,9
zzz     CALL downhl
        DJNZ zzz
        LD B,sirka_okna+1
w4      LD (HL),255
        INC HL
        DJNZ w4
        POP HL
        LD B,sirka_okna+1

w1
        LD (HL),255
        INC HL
        DJNZ w1
        DEC HL
        LD B,8
aa      CALL downhl
        DJNZ aa
        LD (konec_pozice+1),HL

zacatek_pozice
        LD HL,0
        LD A,%10000000
v3      LD B,vyska_okna-9
        CALL cara_dolu
        CALL downhl
        LD (spodni_pozice+1),HL
konec_pozice
        LD HL,0
        LD A,1
v2       LD B,vyska_okna-8
        CALL cara_dolu

spodni_pozice
        LD HL,0
        LD B,sirka_okna+1
w2      LD (HL),255
        INC HL
        DJNZ w2

        RET

cara_dolu
        LD E,A
c0      PUSH BC

        PUSH DE
        CALL downhl
        POP DE
        LD A,(HL)
        OR E
        LD (HL),A
        POP BC
        DJNZ c0


        RET

kresli_logo
        LD DE,sprite
        LD B,8
menu0
        PUSH BC
        PUSH DE

        LD A,(DE)
        LD (HL),A

        CALL downhl

        POP DE
        INC DE
        POP BC
        DJNZ menu0
        OPT pause
        RET

downhl  INC H
        LD A,H
        AND 7
        RET NZ
        LD A,L
        ADD A,32
        LD L,A
        LD A,H
        JR C,downhl2
        SUB 8
        LD H,A

downhl2 CP 88
        RET C
        LD H,64
        RET




sprite
        DEFB %00000001
        DEFB %00000011
        DEFB %00000111
        DEFB %00001111
        DEFB %00011111
        DEFB %00111111
        DEFB %01111111
        DEFB %11111111


