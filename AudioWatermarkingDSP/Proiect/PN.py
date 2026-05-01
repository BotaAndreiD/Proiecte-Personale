import numpy as np

# Generam 4000 de valori aleatoare de -1 si 1
pn_sequence = np.random.choice([-1, 1], size=4000)

with open('PN.dat', 'w') as f:
    for val in pn_sequence:
        f.write(f"{val},\n")

print("Fisierul PN.dat a fost generat!")