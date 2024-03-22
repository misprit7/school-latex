
import matplotlib.pyplot as plt

import numpy as np

lam = 633e-9
w0 = 4e-6
d = 0.05
D = 1
scr = 0.02
N = 1000
z0 = w0**2*np.pi/lam
k = 2*np.pi/lam

x = np.linspace(-scr, scr, N, dtype=np.cdouble)
y = np.linspace(-scr, scr, N, dtype=np.cdouble)

X, Y = np.meshgrid(x, y)

I = np.zeros((N, N))

def w(z):
    return w0*np.sqrt(1+(z/z0)**2)
def R(z):
    return z*(1+(z0/z)**2)

rho = (X**2+Y**2)**0.5
E = np.zeros_like(X)
for z in (D-d/2, D+d/2):
    E += w0/w(z)*np.exp(rho**2/w(z)**2)*np.exp(1j*k*rho**2/2/R(z))*np.exp(1j*k*z-1j*np.arctan(z/z0))
I = np.abs(E)**2

plt.imshow(I, extent=(-scr, scr, -scr, scr), origin='lower', cmap='gray')
plt.xlabel('X (cm)')
plt.ylabel('Y (cm)')
plt.title('Interference Pattern of Offset Gaussian Beams')
plt.show()

