import numpy as np
from scipy.io import wavfile

# 1. Încarcă fișierul audio
# Pune fișierul 'alarma.wav' în același folder cu scriptul
fs, data = wavfile.read('alarma.wav')

# 2. Conversie în Mono (dacă este Stereo)
if len(data.shape) > 1:
    data = data[:, 0]

# 3. Limităm la 16384 de eșantioane (dimensiunea din laborator)
# Dacă fișierul e mai scurt, îl completăm cu zero-uri
lungime_tinta = 4000
if len(data) > lungime_tinta:
    data_final = data[:lungime_tinta]
else:
    data_final = np.pad(data, (0, lungime_tinta - len(data)), 'constant')

# 4. Ne asigurăm că datele sunt pe 16 biți (short)
data_final = data_final.astype(np.int16)

# 5. Scriem fișierul .dat pentru VisualDSP++
with open('audio_data.dat', 'w') as f:
    for sample in data_final:
        f.write(f"{sample},\n")

print(f"Succes! Fișierul 'audio_data.dat' a fost creat cu {len(data_final)} eșantioane.")