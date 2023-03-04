# from math import comb

# n = 100
# p = 0.6
# P = sum([comb(n, k) * p**k * (1-p)**(n-k) for k in range(1, 51)])
# print(P)

# import numpy as np
# import matplotlib.pyplot as plt
# from scipy.stats import norm

# ns = (1,2,3,4,5,10,50)

# u = np.array([1/3, 1/3, 1/3])
# S = [u]

# for i in range(1, max(ns)+1):
#     s = np.convolve(u, S[-1])
#     S.append(s)

# fig,ax = plt.subplots(nrows=4, ncols=2, sharey=True)
# for i,n in enumerate(ns):
#     a = ax[i//2,i%2]
#     a.plot(S[n-1], label='$S_n$')
#     a.title.set_text(f'n={n}')
#     mu = n
#     var = 2/3 * (n)
    
#     x = np.arange(len(S[n-1]))
#     a.plot(norm.pdf(x, mu, var**0.5), label=f'$N({mu},{round(var,1)})$')
#     a.legend()

# plt.show()

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

ns = (1,2,3,4,5,10,50)

x = np.array([-1, 0, 1, 2, 3, 4])
y = np.array([1/15, 1/15, 11/15, 1/15, 0, 1/15])
X = [x]
T = [y]

for i in range(1, max(ns)+1):
    first = X[-1][0]
    last = X[-1][-1]
    X.append(np.insert(np.append(X[-1], [last+1, last+2, last+3, last+4]), 0, first-1))
    T.append(np.convolve(y, T[-1]))

fig,ax = plt.subplots(nrows=4, ncols=2, sharey=True)
for i,n in enumerate(ns):
    a = ax[i//2,i%2]
    a.plot(X[n-1], T[n-1], label='$S_n$')
    a.title.set_text(f'n={n}')
    x = X[n-1]
    t = T[n-1]
    mu = sum([x[i] * y for i,y in enumerate(t)])
    var = sum([(x[i]-mu)**2 * y for i,y in enumerate(t)])
    
    a.plot(X[n-1], norm.pdf(X[n-1], mu, var**0.5), label=f'$N({round(mu)},{round(var,1)})$')
    a.legend()

plt.tight_layout()
plt.show()


