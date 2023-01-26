import numpy as np
import matplotlib.pyplot as plt

X = np.linspace(0, np.pi/2, 50)

def u(x, t):
    s = np.zeros_like(x)
    for n in range(1, 6):
        s+= -(-2*np.pi*(2*n-1)*(-1)**n-8)/(np.pi*(2*n-1)**3)*np.sin((2*n-1)*x)*np.exp(-(2*n-1)**2*t)
        print(s[-1])
    return s

T = [0, 0.02, 0.08, 0.2, 0.8, 2]
U=[u(X, t) for t in T]
# U=[u(X, t) for t in {0}]

for t, a in zip(T, U):
    plt.plot(X, a, label=f'Time t={t}')
plt.legend()
plt.title('First 5 terms of solutions')
plt.xlabel('x')
plt.ylabel('u(x)')
plt.show()

