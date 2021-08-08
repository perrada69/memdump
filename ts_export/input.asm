;  ixh = d  lka vstupu
;  hl = adresa na obrazovce

INPUT   EI
        LD (INPOS+1),HL
;       LD (INCOL+1),A
        LD HL,23296
        LD B,IXH
IN1     LD (HL),32
        INC HL
        DJNZ IN1
        LD (HL),B
        RES 5,(IY+1)
        XOR A
        LD (CURSOR+1),A
IN2     LD B,IXH
INPOS   LD HL,0
        LD (X),HL
        LD HL,23296
CURSOR  LD C,0
IN3     LD A,L
        CP C
        LD A,">"
        CALL Z,print_char
        LD A,(HL)
        CALL print_char
        INC HL
        DJNZ IN3
        LD A,L
        CP C
        LD A,"<"
        CALL Z,print_char
        CALL INKEY
        CP 1
        RET Z
        CP 13
        RET Z

        LD HL,IN2
        PUSH HL
        LD HL,CURSOR+1
        CP 8
        JR Z,CURSLEFT
        CP 9
        JR Z,CURSRGHT
        CP 12
        JR Z,BCKSPACE
        CP 199
        JR Z,DELETE
        CP 32
        RET C
        CP 128
        RET NC
        EX AF,AF'
        LD A,(HL)
        CP IXH
        RET NC
        INC (HL)
        LD L,(HL)
        DEC L
        LD H,23296/256
INS     LD A,(HL)
        OR A
        RET Z
        EX AF,AF'
        LD (HL),A
        INC HL
        JR INS
CURSLEFT LD A,(HL)

        OR A
        RET Z
        DEC (HL)
        RET
CURSRGHT LD A,(HL)
        CP IXH
        RET NC
        INC (HL)
        RET
DELETE  LD A,(HL)
        CP IXH
        RET Z
        INC A
        JR BCK2
BCKSPACE LD A,(HL)
        OR A
        RET Z
        DEC (HL)
BCK2    LD L,A
        LD H,23296/256
        LD E,L
        LD D,H
        DEC E

DEL2    LD A,(HL)
        LDI
        OR A
        JR NZ,DEL2
        EX DE,HL
        DEC HL
        LD (HL)," "
        RET
