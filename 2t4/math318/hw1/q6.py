import random
import math
import matplotlib.pyplot as plt

for days in {365, 669}:
    def birthday(n):
        return len({random.randint(1, days) for i in range(n)}) != n

    N = list(range(2, 61))
    X = []
    for n in N:
        matches = 0
        runs = 0
        for i in range(1000):
            matches += birthday(n)
            runs += 1
        X.append(matches / runs)

    Y = [1 - math.factorial(days) / math.factorial(days - n) / days**n for n in N]

    plt.plot(N, X)
    plt.plot(N, Y)
    plt.show()



