import random
import matplotlib.pyplot as plt

F_n = []
n = 1000
for s in range(n):
    cards = list(range(52))
    F_n.append([52])
    for _ in range(200):
        i = random.randint(0, 51);
        j = random.randint(0, 51);
        temp = cards[i]
        cards[i] = cards[j]
        cards[j] = temp

        f_n = F_n[-1][-1]
        if cards[i] == j:
            f_n-=1
        if cards[j] == i:
            f_n-=1
        if cards[i] == i:
            f_n+=1
        if cards[j] == j:
            f_n+=1
        F_n[-1].append(f_n)

F_n_avg = [sum([f[i] for f in F_n]) / n for i in range(len(F_n[0]))]

print(F_n_avg)

plt.plot(F_n_avg);

plt.show()

