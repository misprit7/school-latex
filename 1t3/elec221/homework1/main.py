import numpy as np
import matplotlib.pyplot as plt

fdelta = 20
fc = 200

t = np.linspace(0, 100, 10000)
s = np.cos(2 * np.pi * fdelta * t) * np.cos(2 * np.pi * fc * t)
c = np.cos(40 * np.pi * t)

plt.plot(t, s)
plt.plot(t, c)
plt.plot(t, -c)

plt.xlabel('Time (s)')
plt.ylabel('Signal output')
plt.title('Signal Output of Signals for 2b')

plt.show()