import numpy as np
import random
import matplotlib.pyplot as plt

n = 1000
p = 0.5

f = np.zeros(n)
f[n//2]=1

for i in range(1000):
    # index = random.randint(0, n-1)
    # f[index] = 1 if random.random() > p else 0
    for j in range(1, len(f)-1):
        f[j] = f[j-1]*(n-j+1)/(2*n)+f[j+1]*(j+1)/(2*n)+1/2*f[j]

plt.plot(f)
plt.show()

