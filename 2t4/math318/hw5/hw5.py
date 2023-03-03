# from math import comb

# n = 100
# p = 0.6
# P = sum([comb(n, k) * p**k * (1-p)**(n-k) for k in range(1, 50)])
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

u = np.array([1/3, 1/3, 1/3])
T = [u]

for i in range(1, max(ns)+1):
    s = np.convolve(u, T[-1])
    T.append(s)

fig,ax = plt.subplots(nrows=4, ncols=2, sharey=True)
for i,n in enumerate(ns):
    a = ax[i//2,i%2]
    a.plot(S[n-1], label='$S_n$')
    a.title.set_text(f'n={n}')
    mu = n
    var = 2/3 * (n)
    
    x = np.arange(len(S[n-1]))
    a.plot(norm.pdf(x, mu, var**0.5), label=f'$N({mu},{round(var,1)})$')
    a.legend()

plt.show()


