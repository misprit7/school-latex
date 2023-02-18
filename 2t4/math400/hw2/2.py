import numpy as np 
from scipy.special import jv, jn_zeros
import matplotlib.pyplot as plt

zn = np.array([5.4336, 8.7388, 11.9533, 15.1365, 18.3053])
r = np.linspace(0, 1, 1000)
Jr = np.array([jv(np.sqrt(5), z*np.sqrt(r)) for z in zn])
An = np.trapz(np.exp(r)*Jr, r) / np.trapz(Jr**2, r)


for t in [0, 0.01, 0.03, 0.1]:
    u = sum([Jr[i] * An[i] * np.sqrt(r) * np.exp(-zn[i]**2 * t / 4) for i in range(len(Jr))])

    plt.plot(r, u, label=f"t={t}")
plt.legend()
plt.xlabel("r")
plt.ylabel("u(r,t)")
plt.show()

for r in [1/4, 3/4]:
    t = np.linspace(0, 0.7, 1000)
    Jr = np.array([jv(np.sqrt(5), z*np.sqrt(r)) for z in zn])
    u = sum([Jr[i] * An[i] * np.sqrt(r) * np.exp(-zn[i]**2 * t / 4) for i in range(len(Jr))])

    plt.plot(t, u, label=f"r={r}")

plt.legend()
plt.xlabel("t")
plt.ylabel("u(r,t)")
plt.show()


