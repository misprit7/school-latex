import matplotlib.pyplot as plt
import random
import numpy as np
from collections import Counter


n = 1000
steps = 200000

X = [0]
for i in range(steps):
    newX = X[-1]
    if random.random() < X[-1] / n:
        newX-=1
    if random.random() < (n-X[-1]) / n:
        newX+=1
    X.append(newX)

plt.plot(X)
plt.show()
        
occur1 = Counter(X[:1000])
occur2 = Counter(X[1000:2000])
occur3 = Counter(X[10000:])

plt.bar(occur1.keys(), occur1.values())
plt.show()
plt.bar(occur2.keys(), occur2.values())
plt.show()
plt.bar(occur3.keys(), occur3.values())
plt.show()
        


