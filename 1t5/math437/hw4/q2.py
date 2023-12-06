
N = 1000

pairs = []
for x in range(1,N):
    for y in range(1,N):
        if x**3-y**2 == 9:
            pairs += (x,y)

print(pairs)
