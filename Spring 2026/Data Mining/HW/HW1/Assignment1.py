import numpy as np
import pandas as pd

data = [[1.2, 3, 1.7],
        [2.4, 5, 2.4],
        [4.8, 35, 1.2],
        [6.6, 60, 3.1],
        [-0.5, 24, 3.3],
        [3.4, 32, 8.4],
        [2.1, 1, 6.5],]

matrix_array = np.array(data)

#Prob 2a
X1 = matrix_array[:, 0]
X1mean = X1.mean()
print("-----PROBLEM 2a-----")
print(X1mean)

#Prob 2b
X2 = matrix_array[:, 1]
X3 = matrix_array[:, 2]
covariance = np.cov(X2, X3)[0,1]
print("-----PROBLEM 2b-----")
print(covariance)

#Prob 2c
X2mean = X2.mean()
X3mean = X3.mean()
print("-----PROBLEM 2c-----")
print("(")
print(X1mean)
print(X2mean)
print(X3mean)
print(")")

#Prob 2d
cov_array = np.vstack((X1,X2))
cov_matrix = np.cov(cov_array)
print("-----PROBLEM 2d-----")
print(cov_matrix)

#Prob 2e
Dcov_matrix = np.cov(data, rowvar=False)
print("-----PROBLEM 2e-----")
print(Dcov_matrix)

#Prob 2f
X1X2cov = np.cov(X1, X2)[0, 1]
VarX1 = Dcov_matrix[0,0]
VarX2 = Dcov_matrix[1,1]
Ans2f = X1X2cov / (VarX1 * VarX2)
print("-----PROBLEM 2f-----")
print(Ans2f)

#prob 2g
totalVariance = np.var(data, ddof=1)
print("-----PROBLEM 2g-----")
print(totalVariance)

#prob 3a
a = np.array([1.2, -2.3, 4, 7.1, -3.12])
b = np.array([23.2, 3, 1.2, -3.21, 5])
c = np.array([8.2, -4.6, 2, 1, -2])

L2_AC = np.linalg.norm(a - c)
print("-----PROBLEM 3a-----")
print(L2_AC)

#prob 3b
L1_BA = np.linalg.norm(b - a, ord =1)
print("-----PROBLEM 3b-----")
print(L1_BA)

#prob 3c
cosTheta = np.dot(a, c) / (np.linalg.norm(a) * np.linalg.norm(c))
angle = np.degrees(np.arccos(cosTheta))
print("-----PROBLEM 3c-----")
print(angle)

#prob 4b
D = np.array([[36.6, 1, 32],
     [38, 3, 21],
     [37, 4, 67],
     [39, 4, 11],
     [27, 2, 71],
])

x3 = D[2]
x5 = D[4]

dist = np.linalg.norm(x3 - x5)
print("-----PROBLEM 4b-----")
print(dist)