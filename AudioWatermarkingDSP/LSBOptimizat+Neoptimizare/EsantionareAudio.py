import numpy as np
from scipy.io import wavfile

fs, data = wavfile.read('alarma.wav')

if len(data.shape) > 1:
    data = data[:, 0]

lungime_tinta = 4000
if len(data) > lungime_tinta:
    data_final = data[:lungime_tinta]
else:
    data_final = np.pad(data, (0, lungime_tinta - len(data)), 'constant')

data_final = data_final.astype(np.int16)

with open('audio_data.dat', 'w') as f:
    for sample in data_final:
        f.write(f"{sample},\n")

print(f"Succes! Fișierul 'audio_data.dat' a fost creat cu {len(data_final)} eșantioane.")