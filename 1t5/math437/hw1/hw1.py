import math

ans = []
odd = False
for m in range(1,500, 2 if odd else 1):
    for n in range(1,500, 2 if odd else 1):
        if (3*m+1)%n==0 and (n**2+3)%m==0:
            ans += [(m,n, (3*m+1)//n, (n**2+3)//m)]

# xy = []
# for x in range(1,500):
#     for y in range(1,500):
#         d = (x*y)**2-108-12*y
#         if d>0 and math.isqrt(d)**2 == d and (2*x*y-12+(2*d)**2)%12==0:
#         # if d>=0 and math.isqrt(d)**2 == d:
#             xy += [(x,y)]

# for (n,l) in [(2,1),(3,3),(4,3),(5,1),(6,3),(7,5),(8,7),(9,9)]:
#     m = (n**2+3)//l
#     if (n**2+3)%l == 0 and (3*m+1)%n == 0 and m%2 == 1 and n%2 == 1:
#         print(n,l)


# for k in range(4,33):
#     if (3*k**2+1)%(k-3) == 0 and (9*k+1)%(k-3) == 0:
#         m,n = ((3*k**2+1)//(k-3), (9*k+1)//(k-3))
#         if m%2 == 1 and n%2 == 1:
#             print(m,n)

for a in range(1,21):
    if 13%(2*a-3) == 0 and (a+18)%(2*a-3) == 0:
        m,n = (13//(2*a-3), (a+18)//(2*a-3))
        if m%2 == 1 and n%2 == 1 and m > 0 and n > 0:
            print(m,n)


# print(ans)
# for i in ans:
#     if i[1] != i[3]+9: print(i)
