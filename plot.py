import numpy as np
#import matplotlib
import math 
import matplotlib.pyplot as plt

# DATA READ
data_1 = np.loadtxt("eigenvalues_noeh.dat")
omega = data_1[0:,6]            # eig (eV) column
ec = data_1[0:,4]               # ec (eV) column
ev = data_1[0:,5]               # ev (eV) column
dip = data_1[0:,7]              # abs(dipole)^2 column


# Calculation
const = 16 * (3.1416 ** 2) * (13.605 ** 2)
omega = ec - ev, #when (ec-ev)=eig, then omega=ec-ev

#gaussian = (1/(0.5* math.sqrt(2 * 3.1416)))*  math.exp(-(X-omega)​**2 /  (2​*(0.5**2)))   
#dip_ = dip * gaussian

