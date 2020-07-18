#!/usr/bin/python3
import os
import io
import sys
import numpy as np
import matplotlib.pyplot as plt
import math

#####STEP-1:

train=np.genfromtxt(r'train.csv',delimiter=',',skip_header=1)
x_train=train[:,[0]]
y_train=train[:,[1]]
n_train=x_train.shape[0]

New_x_train=np.hstack((np.ones((x_train.shape[0],1)),x_train))

#####STEP-2:

w=np.random.random((2,1))
#print (w)

#####STEP-3:

x_prime = New_x_train.dot(w)
plt.plot(x_train,y_train,'b.',x_train,x_prime,'g')
plt.show()

#####STEP-4:

inter=New_x_train.T
inter=inter.dot(y_train)
product=(New_x_train.T).dot(New_x_train)
inverse=np.linalg.inv(product)
w_direct=inverse.dot(inter)
new_x_prime=New_x_train.dot(w_direct)
plt.plot(x_train,y_train,'b.',x_train,new_x_prime,'g')
plt.show()

#####STEP-5:

eta=0.00000001
for i in range(0,2):
    for j in range(1,n_train):
        x=x_train[j][0]
        x=np.array([[1,x]])
        x = x.T
        mid=((w.T).dot(x))
        mid= mid[0][0]
        mid= (mid - y_train[j][0])
        mid=eta*mid*np.array(x)
        w=w-mid
        if j%100==0:
            x_prime = New_x_train.dot(w)
            plt.plot(x_train,y_train,'b.',x_train,x_prime,'g')
plt.show()

#####STEP-6:

x_prime = New_x_train.dot(w)
plt.plot(x_train,y_train,'b.',x_train,x_prime,'r')
plt.show()

#####STEP-7:

test=np.genfromtxt(r'test.csv',delimiter=',',skip_header=1)
x_test=test[:,[0]]
y_test=test[:,[1]]
n_test=x_test.shape[0]
New_x_test=np.hstack((np.ones((x_test.shape[0],1)),x_test))
y_pred1 = New_x_test.dot(w)
y_pred2 = New_x_test.dot(w_direct)
s1=0.0
s2=0.0
for i in range(1,n_test):
    s1=s1+(float(y_pred1[i][0]-y_test[i][0]))*(float(y_pred1[i][0]-y_test[i][0]))
    s2=s2+(float(y_pred2[i][0]-y_test[i][0]))*(float(y_pred2[i][0]-y_test[i][0]))

err1=math.sqrt(s1/n_test)
err2=math.sqrt(s2/n_test)

print ("root mean squared error between y_pred1 and y_test:",err1)
print ("root mean squared error between y_pred2 and y_test:",err2)
