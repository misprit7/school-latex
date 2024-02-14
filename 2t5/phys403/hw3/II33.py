import numpy as np
import matplotlib.pyplot as plt

T = np.linspace(0.01, 300, 1000)
hbar = 1.055e-34
omega = 1e3
kb = 1.381e-23


# C = (hbar*omega)**2*np.exp(hbar*omega/(kb*T))/(kb*T**2*(np.exp(hbar*omega/(kb*T)-1)**2))
C = kb*(hbar*omega/(2*kb*T))**2/np.sinh(hbar*omega/(2*kb*T))**2


plt.plot(T, C)
plt.plot(T, T*0+kb)
plt.axvline(x=hbar*omega/2/kb, color='g', linestyle='-')
plt.title("Heat Capacity of Quantum Harmonic Oscillator")
plt.xlabel("Temperature (K)")
plt.ylabel("Heat Capacity (J/K)")
plt.show()

