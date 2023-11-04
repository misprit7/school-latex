N = 10000000
a = [0,1,2] + [0]*(N-3)

seen = {}
repeat_n = -1
repeat_h = ()

for n in range(0,N-3):
    a[n+3] = (5**(n%816)*a[n+2]+n**2*a[n+1]+11*a[n])%2023
    h = (n%816,n%2023,a[n+2],a[n+1],a[n])
    # h = (n%816,n%2023,a[n+3],a[n+2],a[n+1])
    if h in seen:
        print(f'Found at n={n}')
        repeat_n = n
        repeat_h = h
        break
    seen[h] = n

if repeat_n == -1:
    print('No repeat found')
else:
    n1 = seen[repeat_h]
    n2 = repeat_n
    print(f'Found repeat at n1={n1}, n2={n2}')
    print(repeat_h)
    print('Searching for zeros...')
    for n in range(n1,n2+1):
        if a[n] == 0:
            print(f'Found zero at n={n}')
            print(f'Sanity check: n1={n1}, a[{n1}]={a[n1]}, a[{n1}+1]={a[n1+1]}, a[{n1}+2]={a[n1+2]}, (5^({n1}))%2023={(5**n1)%2023}, ({n1}^2)%2023={(5**n1)%2023}')
            print(f'Sanity check: n2={n2}, a[{n2}]={a[n2]}, a[{n2}+1]={a[n2+1]}, a[{n2}+2]={a[n2+2]}, (5^({n2}))%2023={(5**n2)%2023}, ({n2}^2)%2023={(5**n2)%2023}')
            break

# N = 100000
# a7 = [0,1,2] + [0]*(N-3)
# seen = set()
# for n in range(0,N-3):
#     a7[n+3] = (5**(n%6)*a7[n+2]+n**2*a7[n+1]+11*a7[n])%7
#     # if a[n+3] == 0:
#     h = (n+3,n+2,n+1)
#     if h in seen:
#         print(f'Found at n={n}')
#         break
#     seen.add(h)

# print(set(a))
# print(a)

