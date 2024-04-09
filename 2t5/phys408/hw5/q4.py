import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

R = 2
a = 16

F = lambda t,n: np.array([n[1]+R*(1-2*n[0]-n[1]), a*R*(1-n[0]-n[1])-n[1]])
t_eval = np.arange(0, 4.01, 0.01)

sol = solve_ivp(F, [0,4], [1, 1], t_eval=t_eval)

plt.plot(t_eval, sol.y.T[:,0], label='$n_1$')
plt.plot(t_eval, sol.y.T[:,1], label='$n_2$')
plt.axhline(y=(R-1)/(R+1)+sol.y.T[:,0][-1], color='g', linestyle='-', label='$\\frac{R-1}{R+1}$')
plt.axhline(y=(R-1)/(R+1)*0.9+sol.y.T[:,0][-1], color='y', linestyle='-', label='$\\pm 10\%$')
plt.legend()
plt.title('Numerical Solution to Three Level Lasing System')
plt.xlabel('Time (s)')
plt.ylabel('Scaled number in level')
plt.show()

