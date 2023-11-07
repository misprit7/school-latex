import numpy as np

n=5

A5 = np.zeros((n, n))
G = np.zeros((n+2, n+2))

for i in range(n):
    A5[i][i] = -2
    if i > 0:
        A5[i][i-1] = 1
    if i < n-1:
        A5[i][i+1] = 1

for i in range(0,n+2):
    for j in range(0,n+2):
        k = j*(j-(n+1))/(n+1)
        if i < j:
            G[i][j] = k*i/j
        elif i == j:
            G[i][j] = k
        else:
            G[i][j] = k*((n+1)-i)/((n+1)-j)

print(A5)
inv = np.linalg.inv(A5)
print(inv)
print(G)

