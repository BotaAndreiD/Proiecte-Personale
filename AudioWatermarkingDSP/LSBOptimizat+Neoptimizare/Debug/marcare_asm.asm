.section program;
.global _marcare_LSB_asm;

_marcare_LSB_asm:
    /* Salvare registre pe stiva */
    [--SP] = (R7:4, P5:3);

    /* Initializare Pointeri P (nu I) pentru W[] si B[] cu (Z) */
    P3 = R0;                // AudioIn  -> P3
    P4 = R1;                // AudioOut -> P4
    P5 = R2;                // MesajBinar -> P5

    /* Salvam baza mesajului pentru reset */
    I2 = R2;                // Baza MesajBinar (pentru reset)

    P0 = 4000;              // LUNGIME (loop counter)
    P1 = 88;                // LUNGIME_BINAR
    P2 = 0;                 // Contor local bit

    /* Masca 0xFFFE pentru stergere LSB */
    R3.L = 0xFFFE;
    R3.H = 0x0000;

    /* NOP pentru a evita warning ea1056 (9 cycle penalty dupa LC0 write) */
    NOP;

    /* Hardware Loop */
    LSETUP(start_l, end_l) LC0 = P0;
start_l:
        /* Citire AudioIn 16-bit unsigned - P3 suporta (Z) */
        R0 = W[P3++] (Z);

        /* Citire bit din MesajBinar 8-bit unsigned - P5 suporta (Z) */
        R4 = B[P5++] (Z);

        /* Sterge LSB si pune bitul nou */
        R0 = R0 & R3;
        R0 = R0 | R4;

        /* Scriere AudioOut 16-bit */
       W[P4++] = R0;

        /* Verifica daca am consumat toti bitii mesajului */
        P2 += 1;
        CC = P2 == P1;
        IF !CC JUMP skip_reset;
            P5 = I2;        // Reset pointer mesaj la baza
            P2 = 0;
    skip_reset:

end_l: NOP;                 // end_l nu poate fi un branch, NOP rezolva

    /* Restaurare si return */
    (R7:4, P5:3) = [SP++];
    RTS;

_marcare_LSB_asm.end: