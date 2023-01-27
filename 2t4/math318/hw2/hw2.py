import numpy as np
import numpy.random as rn
import matplotlib.pyplot as plt

n=100000
p=0.01

G = rn.geometric(p, n)
plt.hist(G, bins=np.array(range(1, 1001)))
plt.show()

X = np.linspace(0, 1000)
PMF = (1-p)**(X-1)*p
plt.plot(X, PMF)
plt.show()

t = np.linspace(0, 10)
f = np.exp(-t)
plt.plot(t, f)
plt.show()

