import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as integrate

dx = 0.01
dy = 0.001
delta = 0.005
lam = 500e-9
z = 50

k = 2*np.pi/lam

def Eslit(x,y):
    if -dx/2 <= x <= dx/2 and (delta-dy/2 <= y <= delta+dy/2 or -delta-dy/2 <= y <= -delta+dy/2):
        return 1
    else:
        return 0

x = np.linspace(-0.05, 0.05, 300)
y = np.linspace(-0.05, 0.05, 300)

Ex = np.zeros_like(x, dtype=complex)
Ey = np.zeros_like(y, dtype=complex)
for i, xp in enumerate(x):
    integrand = lambda y, x: Eslit(x,y)*np.exp(1j*k*(-x*xp/z+(x**2+y**2)/(2*z)))
    Ir = integrate.dblquad(lambda y,x: np.real(integrand(y,x)), -dx/2, dx/2, lambda _: -dy/2, lambda _: dx/2, epsabs=1e-4)[0]
    Ii = integrate.dblquad(lambda y,x: np.imag(integrand(y,x)), -dx/2, dx/2, lambda _: -dy/2, lambda _: dx/2, epsabs=1e-4)[0]
    Ex[i] = np.exp(1j*k*z)/(lam*z)*np.exp(1j*k*xp**2/(2*z))*(Ir+1j*Ii)

for i, yp in enumerate(y):
    integrand = lambda y, x: Eslit(x,y)*np.exp(1j*k*(-y*yp/z+(x**2+y**2)/(2*z)))
    Ir = integrate.dblquad(lambda y,x: np.real(integrand(y,x)), -dx/2, dx/2, lambda _: -dy/2, lambda _: dx/2, epsabs=1e-4)[0]
    Ii = integrate.dblquad(lambda y,x: np.imag(integrand(y,x)), -dx/2, dx/2, lambda _: -dy/2, lambda _: dx/2, epsabs=1e-4)[0]
    Ey[i] = np.exp(1j*k*z)/(lam*z)*np.exp(1j*k*yp**2/(2*z))*(Ir+1j*Ii)

plt.plot(x, np.abs(np.real(Ex))**2)
plt.title("Fresnell Intensity of Double Slit for y=0 Axis")
plt.xlabel("x' (m)")
plt.ylabel("I (W/m$^2$)")
plt.show()

plt.plot(y, np.abs(np.real(Ey))**2)
plt.title("Fresnell Intensity of Double Slit for x=0 Axis")
plt.xlabel("y' (m)")
plt.ylabel("I (W/m$^2$)")
plt.show()

# plt.plot(x, [Eslit(0, yy) for yy in y])

