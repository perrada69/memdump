;
;            Vypis cisla
;            ===========
;
;            Vstup:
;                     HL ... cislo, ktere chceme vypsat


print_number
        LD A,(soustava)
        CP 16
        JR Z,hex4_string

decimal5
        LD DE,10000
        CALL digit
decimal4
        LD DE,1000
        CALL digit
decimal3
        LD A,(soustava)
        CP 16
        JR Z,hex2_string
        LD DE,100
        CALL digit
decimal2
        LD DE,10
        CALL digit
decimal1
        LD DE,1

digit   LD A,"0"-1
digit2  INC A
        OR A
        SBC HL,DE
        JR NC,digit2
        ADD HL,DE
        CP "9"+1
        JR C,digit3
        ADD A,"A"-"9"-1
digit3
        LD E,A

        LD A,(font4)
        OR A
        LD A,E
        JP Z,print_char
        PUSH HL
        LD HL,(X4b)
        CALL CHAR4b
        LD HL,X4b
        INC (HL)
        POP HL

        RET


;prvni X, pak Y
X4b     DEFB 0,2


hex4    LD DE,$1000
        CALL digit

hex3    LD DE,$100
        CALL digit

hex2    LD DE,$10
        CALL digit
hex1    JR decimal1

hex4_string
        PUSH HL
        LD A,(font4)
        OR A
        JR NZ,hex44
        LD A,"$"
        CALL print_char
        POP HL
        JR hex4
hex44
;        LD A,"$"
 ;       LD HL,(X4b)
  ;      CALL CHAR4b
   ;     LD HL,X4b
    ;    INC (HL)
        POP HL
        JR hex4

hex2_string
        PUSH HL
        LD A,(font4)
        OR A
        JR NZ,hex24
        LD A,"$"
        CALL print_char
        POP HL
        JR hex2

hex24  ; LD A," "
 ;       LD HL,(X4b)

 ;      CALL CHAR4b
 ;       LD HL,X4b
 ;       INC (HL)
        POP HL
        JR hex2

        INCLUDE "print.odn"





