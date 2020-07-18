#!/usr/bin/python

import sys
import os
import math
import numpy as np
import matplotlib.pyplot as plt
sum1 = float(0.0)
sum2 = float(0.0)
train = np.genfromtxt ('train.csv', delimiter=",")
x_train1 = train[:,0]
y_train1 = train[:,1]
x = np.delete(x_train1,0)
y = np.delete(y_train1,0)
l = len(x)
x_train = x.reshape((l,1))
y_train = y.reshape((l,1))
one = np.ones((l,1))
x_train = np.concatenate((one,x_train),axis=1)
##########################################
w = np.random.rand(2,1)
#print x_train[0]
##########################################
plt.plot(x,y,'ro',x ,x_train.dot(w))
plt.show()

##########################################

w_direct = (np.linalg.inv(x_train.transpose().dot(x_train)).dot(np.transpose(x_train))).dot(y_train)
plt.plot(x, y, 'ro', x, x_train.dot(w_direct))
plt.show()
##########################################

for i in range(0,2):
	for j in range(0,l):
		eta = 0.00000001
		x_bar = x[j]
		x_bar = np.array([[1,x_bar]])
		x_bar = x_bar.T
		temp = (w.T.dot(x_bar))
		temp = (temp - y_train[j])
		temp = temp*x_bar*eta
		w = w - temp
		if (j%100 == 0):
			plt.plot(x,y,'ro')
			plt.plot(x,x_train.dot(w))
plt.show()
##########################################
plt.plot(x,y,'ro',x,x_train.dot(w))
plt.show()
##########################################
test = np.genfromtxt ('test.csv', delimiter=",")
xt_test1 = test[:,0]
yt_test1 = test[:,1]
xt = np.delete(xt_test1,0)
yt = np.delete(yt_test1,0)
lt = len(xt)
xt_test = xt.reshape((lt,1))
yt_test = yt.reshape((lt,1))
one = np.ones((lt,1))
xt_test = np.concatenate((one,xt_test),axis=1)
y_pred1 = xt_test.dot(w)
y_pred2 = xt_test.dot(w_direct)
for i in range(0,yt.shape[0]):
	sum1 = sum1 + (float(y_pred1[i] - yt[i]))*(float(y_pred1[i] - yt[i]))
	sum2 = sum2 + (float(y_pred2[i] - yt[i]))*(float(y_pred2[i] - yt[i]))
#print sum1,sum2
rms1 = sum1/len(yt)
rms2 = sum2/len(yt)
rms1=math.sqrt(rms1)
rms2=math.sqrt(rms2)
print "rms1: ",rms1
print "rms2: ",rms2
