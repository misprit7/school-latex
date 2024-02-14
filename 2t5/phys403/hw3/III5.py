import numpy as np
import matplotlib.pyplot as plt

T = np.linspace(10, 4000, 1000)
hbar = 1.055e-34
h = hbar*(2*np.pi)
c = 3e8
kb = 1.381e-23


def C_quantum(T, omega):
    return kb*(hbar*omega/(2*kb*T))**2/np.sinh(hbar*omega/(2*kb*T))**2

Erot = h*c*2000
Evib = h*c*233000

print(Erot / kb)
print(Evib / kb)

C = 3/2*kb + C_quantum(T, Erot/hbar) + C_quantum(T, Evib/hbar)


plt.plot(T, C)
plt.title("Heat Capacity of Quantum Harmonic Oscillator")
plt.xlabel("Temperature (K)")
plt.ylabel("Heat Capacity (J/K)")
plt.show()

