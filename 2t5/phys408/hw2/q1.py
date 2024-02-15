import numpy as np
import matplotlib.pyplot as plt

dx = 0.01
dy = 0.001
delta = 0.005
lam = 500e-9
z = 50

k = 2*np.pi/lam

x = np.linspace(-0.05, 0.05, 1000)
y = np.linspace(-0.05, 0.05, 1000)

kx = k*x/z
ky = k*y/z

Ix = (lam/z*np.sinc(dx*kx/(4*np.pi)))**2
Iy = (lam/z*np.sinc(dy*ky/(4*np.pi))*np.sin(delta*ky/2))**2

plt.plot(x, Ix)
plt.title("Intensity of Double Slit for y=0 Axis")
plt.xlabel("x' (m)")
plt.ylabel("I (W/m$^2$)")
plt.show()

plt.plot(y, Iy)
plt.title("Intensity of Double Slit for x=0 Axis")
plt.xlabel("y' (m)")
plt.ylabel("I (W/m$^2$)")

plt.show()

