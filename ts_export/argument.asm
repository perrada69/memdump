;
;               Vypocet adresy z arguentu dot prikazu
;               =====================================
;

nastav16
        LD A,16
        LD (soustava),A
        RET

nastav10
        LD A,10
        LD (soustava),A
        RET


vypocitej_adresu2
        EX DE,HL
        LD A,(DE)
        INC DE
        LD HL,0

        LD B,16
        CP "#"
        CALL Z,nastav16
        JR Z,readnum3

        CP "$"
        CALL Z,nastav16
        JR Z,readnum3

        LD B,2
        CP "%"
        JR Z,readnum3

        LD B,10
        DEC DE
        CALL nastav10
readnum3
        LD A,(DE)
        SUB "0"
        CP 10
        JR C,readnum4
        SUB "A"-"9"-1

readnum4
        CP 16
        JR C,readnum6
        SUB 32

readnum6
        CP 16
        RET NC

        INC DE
        PUSH DE

        EX DE,HL
        LD HL,0

        PUSH BC
readnum5
        ADD HL,DE
        DJNZ readnum5
        LD D,B
        POP BC
        LD E,A
        ADD HL,DE
        POP DE
        JR readnum3




vypocitej_adresu
        LD A,(HL)

        CP 48
        RET C
        CP 58
        RET NC
        OR A
        SUB 48

        LD (adresa_arg),A
        XOR A
        LD (adresa_arg+1),A

arg1    INC HL
        LD A,(HL)

        CP 48
        RET C
        CP 58
        RET NC
        PUSH HL

        OR A
        SUB 48

        LD HL,(adresa_arg)
        CALL mult10
        LD E,A
        LD D,0
        ADD HL,DE
        LD (adresa_arg),HL

        POP HL
        JR arg1

mult10  LD B,10
        EX DE,HL
        LD HL,0
mult10b ADD HL,DE
        DJNZ mult10b
        RET

adresa_arg  DEFW 0

