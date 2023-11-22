from sympy import factorint

n = 2**3 * 3**3 * 5**2 * 7**2 * 79

def brute_force_count(n):
    count = 0
    for i in range(n):
        if i**3 % n == 1:
            count += 1
    return count

def smart_count(n):
    factors = factorint(n)
    count = 1
    for p,alpha in factors.items():
        if p == 2:
            continue
        if p**(alpha-1)*(p-1)%3 == 0:
            count *= 3
    return count

print(brute_force_count(n), smart_count(n))

