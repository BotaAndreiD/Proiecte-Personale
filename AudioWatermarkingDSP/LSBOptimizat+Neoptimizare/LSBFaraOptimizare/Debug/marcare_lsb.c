#define LUNGIME 4000
#define LUNGIME_BINAR 88

void marcare_LSB(short *in, short *out, unsigned char *m_bin) {
    int i;
    int contor_bit = 0;

    for (i = 0; i < LUNGIME; i++) {
        out[i] = in[i] & 0xFFFE;
        out[i] = out[i] | m_bin[contor_bit];
        contor_bit = (contor_bit + 1) % LUNGIME_BINAR;
    }
}