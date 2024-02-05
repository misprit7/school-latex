import numpy as np
import matplotlib.pyplot as plt

kb = 1e-6
M = 1
g = 1
T = np.linspace(0, 10, 1000)
N = 1e6
ll = 2e-6
ls = 1e-6
eps = M*g*(ll-ls)

E = N*eps*np.exp(-eps/kb/T)/(1+np.exp(-eps/kb/T))
L = N*ll-N*(ll-ls)*np.exp(-eps/kb/T)/(1+np.exp(-eps/kb/T))
L2 = ll*N-E/M/g

plt.plot(T, L)
# plt.plot(T, L2)
plt.axvline(x=eps/kb, color='b', linestyle='-')
plt.axhline(y=1.5, color='r', linestyle='-')
plt.title("Length vs Temperature of Polymer")
plt.xlabel("Temperature (K)")
plt.ylabel("Length (m)")

print(L[0])
plt.show()

