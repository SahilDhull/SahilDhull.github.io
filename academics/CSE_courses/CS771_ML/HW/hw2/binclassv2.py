#!/bin/python
import numpy as np
import matplotlib.pyplot as plt
import scipy
from sklearn import svm
import math

bin = np.loadtxt("binclassv2.txt", delimiter=",")
# bin = np.loadtxt("binclassv2.txt", delimiter=",")
k = bin.shape[1]
bin = bin[bin[:,k-1].argsort()]
bin0,bin1 = np.split(bin, np.where(np.diff(bin[:,k-1]))[0]+1)
x0 = np.delete(bin0,k-1,axis=1)
x1 = np.delete(bin1,k-1,axis=1)
# x0 contains all inputs with y=-1 and x1 contains all inputs with y=+1
mu0 = x0.mean(axis=0)   # mu0 is mu- (mean of all inputs with y=-1)
mu1 = x1.mean(axis=0)   # mu1 is mu+ (mean of all inputs with y=+1)
n0 = x0.shape[0]
n1 = x1.shape[0]
print mu0
print mu1
c0 = x0 - mu0
c1 = x1 - mu1
sigma0sq = np.trace(np.matmul(c0,c0.T))/n0
sigma1sq = np.trace(np.matmul(c1,c1.T))/n1
sigma0 = sigma0sq**0.5      # sigma0 = sigma-
sigma1 = sigma1sq**0.5      # sigma1 = sigma+

print round(sigma0,3)
print round(sigma1,3)
# following vectors are for plotting
x0x = x0[:,0]
x0y = x0[:,1]
x1x = x1[:,0]
x1y = x1[:,1]
# following variables are for calculating boundary of graph
max_x = max(np.maximum(x0x,x1x))
max_y = max(np.maximum(x0y,x1y))
min_x = min(np.minimum(x0x,x1x))
min_y = min(np.minimum(x0y,x1y))
# plotting starts
plt.figure(1)
plt.plot(x0x,x0y,'bo')
plt.plot(x1x,x1y,'ro')
plt.axis([min_x-5,max_x+5,min_y-5,max_y+5])
c = 2*sigma0sq*sigma1sq*(math.log10(sigma0/sigma1)) # constant used in the equation for decision boundary
x = np.linspace(-30., 30.)
y = np.linspace(-30., 30.)[:, None]
# following is the equation for decision boundary
plt.contour(x, y.ravel(), sigma1sq*((x - mu0[0])**2 + (y - mu0[1])**2)-sigma0sq*((x - mu1[0])**2 + (y - mu1[1])**2)+c, [0])
plt.savefig('quadratic2.png')
plt.figure(2)
plt.plot(x0x,x0y,'bo')
plt.plot(x1x,x1y,'ro')
plt.axis([min_x-5,max_x+5,min_y-5,max_y+5])
x = np.linspace(-30., 30.)
y = np.linspace(-30., 30.)[:, None]
# following is the equation for decision boundary
plt.contour(x, y.ravel(), 2*(x*(mu1[0]-mu0[0])+y*(mu1[1]-mu0[1]))+mu0[0]**2+mu0[1]**2-mu1[0]**2-mu1[1]**2, [0])
plt.savefig('linear2.png')

#----------SVM PART----------------
bin_x = np.delete(bin,k-1,axis=1)
bin_y = bin[:,k-1]
clf = svm.SVC(kernel='linear', C=1.0)
clf.fit(bin_x,bin_y)
w = clf.coef_[0]
a = -w[0]/w[1]
xx = np.linspace(-30,30)
yy = a*xx - clf.intercept_[0] / w[1]
plt.figure(3)
plt.plot(x0x,x0y,'bo')
plt.plot(x1x,x1y,'ro')
plt.axis([min_x-5,max_x+5,min_y-5,max_y+5])
plt.plot(xx,yy,'k-')
plt.legend()
plt.savefig('svm2.png')
# plt.show()
