;
;       Obsluha obrazovky

rollup
        LD HL,tabvram + 32
        LD (u1+2),HL
        LD HL,tabvram + 48
        LD (u2+1),HL

        LD B,160                 ;vyska skrolujiciho okna
u0      PUSH BC
u1      LD DE,(0)
u2      LD HL,(0)
        LD BC,32
        LDIR

        LD HL,(u1+2)
        INC HL
        INC HL
        LD (u1+2),HL

        LD HL,(u2+1)
        INC HL
        INC HL
        LD (u2+1),HL

        POP BC
        DJNZ u0
        RET

rolldown

        LD HL,tabvram + 368
        LD (d1+2),HL
        LD HL,tabvram + 352
        LD (d2+1),HL

        LD B,160                 ;vyska skrolujiciho okna
d0      PUSH BC

d1      LD DE,(0)
d2      LD HL,(0)
        LD BC,32
        LDIR

        LD HL,(d1+2)
        DEC HL
        DEC HL
        LD (d1+2),HL

        LD HL,(d2+1)
        DEC HL
        DEC HL
        LD (d2+1),HL

        POP BC
        DJNZ d0
        RET

downde
        INC D
        LD A,D
        AND 7
        RET NZ
        LD A,E
        ADD A,32
        LD E,A
        LD A,D
        JR C,downde2
        SUB 8
        LD D,A
downde2 CP 88
        RET C
        LD D,64
        RET

prvni_adr    EQU 16480-32
druha_adr    EQU 16448-32

iniroll
        RET

delka   EQU 8
vyska   EQU 21

updata   DS delka * vyska * 4

