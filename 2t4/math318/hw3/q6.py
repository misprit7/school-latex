import matplotlib.pyplot as plt 
import numpy as np
from random import randint
from scipy.stats import poisson

p = 1/50
seats = 420
sold = 430
n = 50000

no_shows = []

for _ in range(n):
    no_shows.append(sum(randint(1,50)==1 for _ in range(sold)))

N = np.arange(1,n+1,1)
Xn = []
tot = 0
for i in range(len(no_shows)):
    tot += no_shows[i] < sold-seats
    Xn.append(tot / (i+1))

print(Xn[-1])
plt.plot(N,Xn)
plt.show()

# plt.hist(no_shows, density=True, bins=24)
# X = np.arange(1, 30, 1)
# Y = poisson.pmf(X, mu=sold*p)
# plt.plot(X,Y)

# from math import exp,factorial
# lam = p*sold
# Prob = 0
# for i in range(sold-seats):
#     Prob += lam**i*exp(-lam)/factorial(i)

# print(Prob)

# Prob = 0
# for i in range(seats+1,sold+1):
#     Prob += p**(sold-i)*(1-p)**i*comb(sold,i)

# print(Prob)

# overbooked, total = 0,0
# for _ in range(100000):
#     total += 1
#     overbooked += (sold-sum(randint(1,50)==1 for _ in range(sold))) > seats

# print(overbooked / total)

