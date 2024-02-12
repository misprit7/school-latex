import numpy as np
import matplotlib.pyplot as plt

T = np.linspace(0.01, 300, 1000)
hbar = 1.055e-24
omega = 1e7
kb = 1.381e-23


C = (hbar*omega)**2*np.exp(hbar*omega/(kb*T))/(kb*T**2*(np.exp(hbar*omega/(kb*T)-1)**2))

plt.plot(T, C)

