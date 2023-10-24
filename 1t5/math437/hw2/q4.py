from sympy import divisors, totient, factorial, N
import matplotlib.pyplot as plt

a = []
f = []
d = []
p = []
for n in range(1, 20):
    fac = factorial(n)
    a += [fac/len(divisors(fac))/totient(fac)]
    f += [fac]
    d += [len(divisors(fac))]
    p += [totient(fac)]

b = []
# for n in range(1, 15):
#     b += [N(factorial(n)/2**(len(divisors(factorial(n)))))]

# plt.semilogy(a)
# plt.show()
print(list(zip(a,f,d,p)))
# print([N(a[i+1]/a[i]) for i in range(len(a)-1)])

