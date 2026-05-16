#include <stdio.h>
#include <string.h>
#define LUNGIME 4000
#define LUNGIME_BINAR 88
#define ALFA 20 
short audioIn[LUNGIME] = {
    #include "audio_data.dat"
};
int secventaPN[LUNGIME] = {
    #include "PN.dat"
};
short audioOut[LUNGIME];
static unsigned char mesaj_binar[LUNGIME_BINAR]; 
void main() {
    int i, k, val;
    float m_bipolar;
    printf("--- Proiect TPI: Audio Spread Spectrum ---\n");
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
    printf("Marcare prin spectru imprastiat finalizata.\n");
    while(1);
}
