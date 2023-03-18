import numpy as np
import matplotlib.pyplot as plt
import numpy.random as rn
import random
from tqdm import tqdm

n = 1000000
sims = 1000
directions = [np.array(d) for d in [(1, 0), (0, 1), (-1, 0), (0, -1)]]

# S = np.empty((n, 2))

# for i in range(n-1):
#     S[i+1] = S[i] + random.sample(directions, 1)

# plt.scatter(S.T[0], S.T[1], c=np.arange(0, n), cmap="rainbow", s=0.2)

# plt.show()


n_steps = []
for sim in tqdm(range(sims)):
    S = np.empty((n, 2))

    n_steps.append(n)
    rand = rn.randint(0, 4, size=n)
    for i in range(n-1):
        S[i+1] = S[i] + directions[rand[i]]
        if S[i+1][0] == 0 and S[i+1][1] == 0:
            n_steps[-1] = i+1
            break

plt.hist(n_steps, bins=np.logspace(start=np.log10(1), stop=np.log10(n), num=15))
plt.gca().set_xscale("log")

print(n_steps)
print(len([x for x in n_steps if x == n]))

plt.show()
    
    

