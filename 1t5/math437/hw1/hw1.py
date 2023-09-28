
ans = []
for m in range(1,500, 2):
    for n in range(1,500, 2):
        if (3*m+1)%n==0 and (n**2+3)%m==0:
            ans += [(m,n)]

print(ans)
