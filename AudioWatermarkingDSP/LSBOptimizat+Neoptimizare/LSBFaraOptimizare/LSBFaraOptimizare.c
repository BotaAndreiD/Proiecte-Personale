#include <stdio.h>
#include <string.h>

#define LUNGIME 4000
#define LUNGIME_MESAJ 11
#define LUNGIME_BINAR 88

extern void marcare_LSB(short *in, short *out, unsigned char *m_bin);

short audioIn[LUNGIME] = {
    #include "audio_data.dat"
};
short audioOut[LUNGIME];

static unsigned char mesaj[LUNGIME_MESAJ + 1] = "PROIECT TPI";
static unsigned char mesaj_binar[LUNGIME_BINAR];
static unsigned char mesaj_binar_extras[LUNGIME_BINAR];
unsigned char mesaj_extras[LUNGIME_MESAJ + 1];

void conversie_binar(unsigned char *src, unsigned char *dest, int nr_char) {
    int i, j;
    for (i = 0; i < nr_char; i++) {
        for (j = 0; j < 8; j++) {
            dest[i * 8 + j] = (src[i] >> (7 - j)) & 0x01;
        }
    }
}

void conversie_text(unsigned char *src, unsigned char *dest, int nr_char) {
    int i, j;
    for (i = 0; i < nr_char; i++) {
        dest[i] = 0;
        for (j = 0; j < 8; j++) {
            dest[i] |= (src[i * 8 + j] << (7 - j));
        }
    }
    dest[nr_char] = '\0';
}

void main() {
    int i;

    printf("Proiect TPI: Audio LSB (Varianta Neoptimizata)\n");

    conversie_binar(mesaj, mesaj_binar, LUNGIME_MESAJ);

    marcare_LSB(audioIn, audioOut, mesaj_binar);

    for (i = 0; i < LUNGIME_BINAR; i++) {
        mesaj_binar_extras[i] = audioOut[i] & 0x01;
    }

    conversie_text(mesaj_binar_extras, mesaj_extras, LUNGIME_MESAJ);

    printf("Mesaj Original: %s\n", mesaj);
    printf("Mesaj Extras:   %s\n", mesaj_extras);

    if (strcmp((char*)mesaj, (char*)mesaj_extras) == 0) {
        printf("Status: Succes!\n");
    } else {
        printf("Status: Eroare la extractie!\n");
    }

    while(1);
}