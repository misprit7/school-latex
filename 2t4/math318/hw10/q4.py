import random

n = 10000

c_wins = 0

for _ in range(n):
    coins = [2, 2, 1]
    while True:
        i = random.randint(0,2)

        indices = [0,1,2]
        indices.remove(i)
        if random.random() > 0.5:
            coins[indices[0]]+=1
            coins[indices[1]]-=1
        else:
            coins[indices[0]]-=1
            coins[indices[1]]+=1
        if coins.count(0) != 0:
            print(coins)
            if coins[2] == 0:
                c_wins += 1
            break

print(c_wins / n)

