import matplotlib.pyplot as plt
import numpy as np

X = np.linspace(45, 120)
Y = (1+X/53)*(1+X/60)

plt.plot(X,Y)

