#!/usr/bin/python
import os
import csv
import sys, subprocess

with open("params.txt") as file:
    reader=csv.reader(file,delimiter=' ')
    for row in reader:
        params=row

with open("threads.txt") as file:
    reader=csv.reader(file,delimiter=' ')
    for row in reader:
        threads=row

for i in range(len(threads)):
    for j in range(len(params)):
        for k in range(1,101):
            subprocess.call(['./App',params[j],threads[i]])
            # print a[i],b[j],k
