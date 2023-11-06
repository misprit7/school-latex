import numpy as np

n=5

A5 = np.zeros((n, n))
G = np.zeros((n+1, n+1))

for i in range(n):
    A5[i][i] = -2
    if i > 0:
        A5[i][i-1] = 1
    if i < n-2:
        A5[i][i+1] = 1
# A5[0] = 0
# A5[n] = 0

for i in range(0,n+1):
    for j in range(0,n+1):
        k = j*(j-n)/n
        if i < j:
            G[i][j] = k*i/j
        elif i == j:
            G[i][j] = k
        else:
            G[i][j] = k*(n-i)/(n-j)

inv = np.linalg.inv(A5)
print(A5)
print(inv)
print(G)

