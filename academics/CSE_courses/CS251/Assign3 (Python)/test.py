#!/usr/bin/python
import sys
import os
import numpy as np

w=np.random.random((2,1))
print (w)

x=3
x=np.array([[1,x]]).T
y=np.array([[1,5]])
l=10
l=l-y[0][0]
print "l=",l
print (x)
print (w)
