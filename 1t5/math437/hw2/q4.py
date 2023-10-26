from sympy import divisors, totient, factorial, N, log, factorint
import matplotlib.pyplot as plt

# a = []
# f = []
# d = []
# p = []
# for n in range(1, 20):
#     fac = factorial(n)
#     a += [fac/len(divisors(fac))/totient(fac)]
#     f += [fac]
#     d += [len(divisors(fac))]
#     p += [totient(fac)]

# for i in range(30):
#     if i > 2:
#         print(i, d[-1], N(2**(d[-1]-d[-2])))
# exit()

b = []
d = []
for n in range(1, 26):
    b += [N(factorial(n)/2**(len(divisors(factorial(n)))))]
    d += [len(divisors(factorial(n)))]
    if n > 4:
        # print(n, d[-1], d[-1]-d[-2], len([x for x in divisors(factorial(n-1)) if x%2 == 1 and x%3 == 0 and x%5==0]))
        factors = factorint(factorial(n))
        print(n, d[-1]-d[-2], factors[3]*factors[5])

# plt.semilogy(a)
# plt.show()

print(b)
print([N(b[i+1]/b[i]) for i in range(len(b)-1)])

# print(list(zip(a,f,d,p)))
# print([N(a[i+1]/a[i]) for i in range(len(a)-1)])

