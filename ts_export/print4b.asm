
PRINT4b  PUSH HL
         CALL ADRSET
         POP  BC
         EX   DE,HL
         JR   Z,SECND
FIRST    LD   A,(HL)
         OR   A
         RET  Z
         PUSH HL
         PUSH DE
         PUSH BC
         ADD  A,A
         LD   L,A
         LD   H,0
         ADD  HL,HL
         ADD  HL,HL
         LD   BC,FONT-256
         ADD  HL,BC
         EX   DE,HL
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %11110000
         OR   (HL)
         LD   (HL),A
         POP  BC
         INC  C
         POP  DE
         POP  HL
         INC  HL
SECND    LD   A,(HL)
         OR   A
         RET  Z
         PUSH HL
         PUSH DE
         PUSH BC
         ADD  A,A
         LD   L,A
         LD   H,0
         ADD  HL,HL
         ADD  HL,HL
         LD   BC,FONT-256
         ADD  HL,BC
         EX   DE,HL
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         INC  E
         INC  H
         LD   A,(DE)
         AND  %00001111
         OR   (HL)
         LD   (HL),A
         POP  BC
         INC  C
         POP  DE
         POP  HL
         INC  E
         CALL Z,CTH
         INC  HL
         JP   FIRST

CTH      LD   A,D
         ADD  A,8
         LD   D,A
         RET


;hl=umisteni
;a=kod znaku
CHAR4b     LD   B,A
         AND  %11100000
         LD   A,B
         JR   NZ,CHAR0
         LD   A,32
CHAR0
         PUSH BC
         PUSH DE
         PUSH HL
         PUSH AF
         CALL AADRSET
         OR   A
         JR   Z,ASECND2
         LD   C,$F0
         JR   ASECND1
ASECND2  LD   C,$0F
ASECND1  POP  AF
         EX   DE,HL
         LD   L,A
         LD   H,0
         ADD  HL,HL
         ADD  HL,HL
         ADD  HL,HL
         PUSH BC
         LD   BC,FONT-256
         ADD  HL,BC
         POP  BC
         EX   DE,HL

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         INC  DE
         INC  H

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         INC  DE
         INC  H

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         INC  DE
         INC  H

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         INC  DE
         INC  H

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         INC  DE
         INC  H

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         INC  DE
         INC  H

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         INC  DE
         INC  H

         LD   B,(HL)
         LD   A,C
         CPL
         AND  B
         LD   (HL),A
         LD   A,(DE)
         AND  C
         OR   (HL)
         LD   (HL),A

         POP  HL
         POP  DE
         POP  BC
         INC  L
         RET

;hl=umisteni (0-23,0-63)
AADRSET  LD   A,H
         PUSH HL
         AND  %00011000
         OR   %01000000
         LD   L,0
         RR   H
         RR   L
         RR   H
         RR   L
         RR   H
         RR   L
         LD   H,A
         POP  BC
         BIT  0,C
         JR   NZ,AMODIFY
         LD   A,1
ACONT    SRL  C
         LD   B,0
         ADD  HL,BC
         RET
AMODIFY  XOR  A
         JR   ACONT

ADRSET   LD   A,H
         PUSH HL
         AND  %00011000
         OR   %01000000
         LD   L,0
         RR   H
         RR   L
         RR   H
         RR   L
         RR   H
         RR   L
         LD   H,A
         POP  BC
         BIT  0,C
         LD   A,1
         JR   Z,CONT
         XOR  A
CONT     SRL  C
         LD   B,0
         ADD  HL,BC
         OR   A
         RET

         DEFS -$&$ff

FONT     INCBIN "FONT4B.BIN"
