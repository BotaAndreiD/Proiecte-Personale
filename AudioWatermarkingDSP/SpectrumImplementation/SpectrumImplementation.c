#include <stdio.h>
#include <string.h>

#define LUNGIME 4000
#define LUNGIME_MESAJ 11
#define LUNGIME_BINAR 88
#define ALFA 20 

short audioIn[LUNGIME] = {
    #include "audio_data.dat"
};
int secventaPN[LUNGIME] = {
    #include "PN.dat"
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
    int i, k, val;
    float m_bipolar;

    printf("Proiect TPI: Audio Spread Spectrum Complet\n");

    conversie_binar(mesaj, mesaj_binar, LUNGIME_MESAJ);

    for (i = 0; i < LUNGIME; i++) {
        k = i % LUNGIME_BINAR; 

        if (mesaj_binar[k] == 0) 
            m_bipolar = -1.0;
        else 
            m_bipolar = 1.0;

        val = audioIn[i] + (int)(ALFA * m_bipolar * secventaPN[i]);
        
        if (val > 32767) val = 32767;
        else if (val < -32768) val = -32768;
        
        audioOut[i] = (short)val;
    }

    for (k = 0; k < LUNGIME_BINAR; k++) {
        float suma_corelatie = 0.0;

        for (i = k; i < LUNGIME; i += LUNGIME_BINAR) {
            int semnal_marcat_pur = audioOut[i] - audioIn[i];
            suma_corelatie += (float)semnal_marcat_pur * secventaPN[i];
        }

        if (suma_corelatie > 0) {
            mesaj_binar_extras[k] = 1;
        } else {
            mesaj_binar_extras[k] = 0;
        }
    }

    conversie_text(mesaj_binar_extras, mesaj_extras, LUNGIME_MESAJ);

    printf("Mesaj Original: %s\n", mesaj);
    printf("Mesaj Extras:   %s\n", mesaj_extras);

    if (strcmp((char*)mesaj, (char*)mesaj_extras) == 0) {
        printf("Status: Succes (Spread Spectrum)!\n");
    } else {
        printf("Status: Eroare!\n");
    }

    while(1);
}