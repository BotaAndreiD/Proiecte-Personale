.section program;
.global _marcare_LSB_asm;

_marcare_LSB_asm:  
    [--SP] = (R7:4, P5:3);

    P3 = R0;               
    P4 = R1;                
    P5 = R2;               

    
    I2 = R2;               

    P0 = 4000;            
    P1 = 88;               
    P2 = 0;                

    R3.L = 0xFFFE;
    R3.H = 0x0000;

    NOP;

    LSETUP(start_l, end_l) LC0 = P0;
start_l:
    
        R0 = W[P3++] (Z);

        R4 = B[P5++] (Z);

        R0 = R0 & R3;
        R0 = R0 | R4;

       W[P4++] = R0;

        P2 += 1;
        CC = P2 == P1;
        IF !CC JUMP skip_reset;
            P5 = I2;       
            P2 = 0;
    skip_reset:

end_l: NOP;      

    (R7:4, P5:3) = [SP++];
    RTS;

_marcare_LSB_asm.end: