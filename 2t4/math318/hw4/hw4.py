import numpy as np
import numpy.random as rn
import matplotlib.pyplot as plt

num = 10000

normals = rn.normal(np.zeros(num))
exps = rn.exponential(np.ones(num)/2)
cauchys = rn.standard_cauchy(num)
for dist in (normals, exps, cauchys):
    averages = []
    s = 0
    ns = np.arange(num)
    for n in ns:
        s += dist[n]
        averages.append(s/(n+1))

    plt.plot(ns, averages)
    plt.show()

 # from random import uniform
# import matplotlib.pyplot as plt
# import math

# n = 10000

# rtheta = [(uniform(0,1),uniform(0, 2*math.pi)) for _ in range(n)]
# pts = [(r*math.cos(t), r*math.sin(t)) for (r,t) in rtheta]
# l = list(zip(*pts))

# plt.scatter(l[0], l[1])
# plt.plot()
# plt.show()

# from random import uniform
# import matplotlib.pyplot as plt

# n = 10000

# pts = [(uniform(-1,1),uniform(-1,1)) for _ in range(n)]
# pts_inside = [t for t in pts if t[0]**2 + t[1]**2 < 1]
# l = list(zip(*pts_inside))

# plt.scatter(l[0], l[1])
# plt.plot()
# plt.show()

