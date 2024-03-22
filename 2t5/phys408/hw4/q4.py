import numpy as np

import matplotlib.pyplot as plt

n1 = 1.5
n2 = 1.38
n3 = 1.77

M21 = 1/(2*n2)*np.array([[n2+n1, n2-n1], [n2-n1, n2+n1]])
M12 = 1/(2*n1)*np.array([[n2+n1, n1-n2], [n1-n2, n2+n1]])
M13 = 1/(2*n1)*np.array([[n3+n1, n1-n3], [n1-n3, n3+n1]])
M31 = 1/(2*n3)*np.array([[n1+n3, n3-n1], [n3-n1, n1+n3]])

Md = np.array([[1j, 0], [0, -1j]], dtype=np.cdouble)
Ms = np.array([[-1, 0], [0, -1]])

M21inv = np.linalg.inv(M21)
M12inv = np.linalg.inv(M12)
Mdinv = np.linalg.inv(Md)
Msinv = np.linalg.inv(Ms)
M13inv = np.linalg.inv(M13)
M31inv = np.linalg.inv(M31)

N = 20

U_for = np.zeros(2*N, dtype=np.cdouble)
U_back = np.zeros(2*N, dtype=np.cdouble)

U = np.array([1, 0])

for i in range(1, int(N/2+1)):
    U = np.matmul(Mdinv, U)
    U = np.matmul(M12inv, U)
    U_for[2*N-2*i] = U[0]
    U_back[2*N-2*i] = U[1]
    U = np.matmul(Mdinv, U)
    U = np.matmul(M12, U)
    U_for[2*N-2*i+1] = U[0]
    U_back[2*N-2*i+1] = U[1]

U = np.matmul(Mdinv, U)
U = np.matmul(M13, U)
U = np.matmul(Msinv, U)
U = np.matmul(M31, U)

for i in range(int(N/2+1), N+1):
    U = np.matmul(Mdinv, U)
    U = np.matmul(M12inv, U)
    U_for[2*N-2*i] = U[0]
    U_back[2*N-2*i] = U[1]
    U = np.matmul(Mdinv, U)
    U = np.matmul(M12, U)
    U_for[2*N-2*i+1] = U[0]
    U_back[2*N-2*i+1] = U[1]

print(U)
plt.plot(np.abs(U_for)**2, label='Forward light')
plt.plot(np.abs(U_back)**2, label='Backward light')
plt.legend()
plt.xlabel('Layer number')
plt.ylabel('relative intensity (W/m$^2$)')
plt.title('Intensity of light in quarter wave stack with impurity')
plt.show()

