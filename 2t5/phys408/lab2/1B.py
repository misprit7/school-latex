
import matplotlib.pyplot as plt
import numpy as np

X = np.linspace(45, 120)
Y = (1-X/53)*(1-X/60)

plt.axvline(x=53, color='red', linestyle='--')
plt.axvline(x=60, color='red', linestyle='--')

plt.axhline(y=1, color='blue', linestyle='--')

plt.xlabel('x (cm)')
plt.ylabel('Stability criteria')

plt.title('Stability Criteria for Lasing Cavity')
plt.plot(X,Y)
plt.show()
