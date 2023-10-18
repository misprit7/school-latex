from sympy import divisors, totient, factorial, N
import matplotlib.pyplot as plt

a = []
for n in range(1, 20):
    a += [factorial(n)/len(divisors(n))/totient(n)]

b = []
# for n in range(1, 15):
#     b += [N(factorial(n)/2**(len(divisors(factorial(n)))))]

# plt.semilogy(a)
# plt.show()
print(a)

