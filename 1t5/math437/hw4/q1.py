
sols = []

for n in range(1,100):
    finished = False
    for a in range(1,10):
        if finished:
            break
        for b in range(1,10):
            if 2**a+2**b==n**2:
                sols += [(n,a,b)]
                finished = True
                break

print(sorted(set(sols)))

