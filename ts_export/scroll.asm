;
;       Obsluha obrazovky
rollup
        LD HL,updata
        JP roll

rolldown
        LD HL,downdata

roll    LD (sp_st+1),SP
        DI
        LD SP,HL
        LD A,21 * 8

roll1   POP HL
        POP DE

        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        LDI
        DEC A
        JR NZ,roll1

sp_st   LD SP,0
        EI
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

iniroll LD B,vyska * delka
        LD HL,updata
ir1
ini1    LD DE,prvni_adr+32
        LD (HL),E
        INC HL
        LD (HL),D
        INC HL
        CALL downde
        LD (ini1+1),DE

ini2    LD DE,druha_adr+32
        LD (HL),E
        INC HL
        LD (HL),D
        INC HL
        CALL downde
        LD (ini2+1),DE


        DJNZ ir1

        LD B,delka * vyska
        LD HL,updata - 1

ir2
ini12   LD DE,prvni_adr
        LD (HL),D
        DEC HL
        LD (HL),E
        DEC HL
        CALL downde
        LD (ini12+1),DE

ini22   LD DE,druha_adr
        LD (HL),D
        DEC HL
        LD (HL),E
        DEC HL
        CALL downde
        LD (ini22+1),DE
        DJNZ ir2
        RET

delka   EQU 8
vyska   EQU 21


downdata DS delka * vyska * 4
updata   DS delka * vyska * 4

