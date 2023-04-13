import random

n = 10
N = 1000
times = []
for _ in range(n):
    opinions = [i for i in range(N)]
    t = 0
    while len(set(opinions)) > 1:
        t += 1
        x = random.randint(0,N-1)
        y = random.randint(0,N-1)
        while x == y: y = random.randint(0,N-1)
        opinions[x] = opinions[y]
    times.append(t)
et = sum(times) / n
print(times)
print(et)

