import numpy as np
import matplotlib.pyplot as plt

eb = 1
U = 12
kb = 1.381e-23
T = np.linspace(0.01/kb, 20/kb, 1000)
dT = T[1] - T[0]

beta = 1/(kb*T)
Z = 1+2*np.exp(beta*eb)+np.exp(-beta*(-2*eb+U))


ne = 1/Z * (2*np.exp(beta*eb)+2*np.exp(-beta*(-2*eb+U)))

plt.plot(kb*T, ne)
plt.title("Average Number of Electrons in One Impurity")
plt.xlabel("$k_BT$ (J)")
plt.ylabel("Number of Electrons")
plt.show()

E = 1/Z * (-2*eb*np.exp(beta*eb)+(-2*eb+U)*np.exp(-beta*(-2*eb+U)))

plt.plot(kb*T, E)
plt.title("Average Energy in One Impurity")
plt.xlabel("$k_BT$ (J)")
plt.ylabel("Energy (J)")
plt.show()

C = np.gradient(E, dT)

plt.plot(kb*T, C)
plt.title("Heat Capacity of an Impurity")
plt.xlabel("$k_BT$ (J)")
plt.ylabel("Heat Capacity (J/K)")
plt.show()

