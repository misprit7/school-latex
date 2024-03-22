import numpy as np

c = 3e8
nu = 4.74e12
d = 5
R1 = -8
R2 = -15
g1 = 1+d/R1
g2 = 1+d/R2

for lm in range(0,7):
    q = nu*d/c-1/np.pi*(1+lm)*np.arccos(np.sqrt(g1*g2))
    print(q)

