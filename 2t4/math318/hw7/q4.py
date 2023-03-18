import numpy as np
import random
import matplotlib.pyplot as plt
from tqdm import tqdm

n = 1000000
sims = 1000
ps = (0.5, 0.51, 0.502)

figa, axa = plt.subplots(3)
for j, p in enumerate(ps):
    X = [0]
    for i in range(n-1):
        X.append(X[i] + (-1 if random.random() > p else 1))
        
    axa[j].plot(list(range(n)), X)
    axa[j].set_title(f'p={p}')

plt.show()

figb, axb = plt.subplots(3)
figc, axc = plt.subplots(3)
for j, p in enumerate(ps):
    T = np.array([n]*sims)
    for sim in tqdm(range(sims)):
        X = 0
        for t in range(n):
            X += -1 if random.random() > p else 1
            if X == 0:
                T[sim] = t
                break

    axb[j].hist(T, bins=np.arange(0, n + 10000, 10000))
    axb[j].set_title(f'p={p}')

    T.sort()
    F = []
    s = 0
    for t in range(n):
        while s < len(T) and T[s] <= t: s += 1
        F.append((sims-s)/sims)

    axc[j].loglog(np.arange(n), F)
    axc[j].set_title(f'p={p}')

plt.show()




