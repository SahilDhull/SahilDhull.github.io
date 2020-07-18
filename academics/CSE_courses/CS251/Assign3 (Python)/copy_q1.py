#!/usr/bin/python
import sys
n=sys.argv[1]
b=float(sys.argv[2])
index=0
neg=0
decimal=0
exit=0
length=len(n)

if b>36 or b<2:
    exit=1

if n.startswith('-'):
    n=n[1:]
    neg=1
    length-=1
if n.startswith('-'):
    exit=1

while True:
    if n[index] == '0':
        n=n[1:]
        length=length-1
        continue
    break

alpha='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
value = {}
j=0;
for i in alpha:
    value[i]=10+j
    j+=1
xyz='0123456789'
j=0
for i in xyz:
    value[i]=j
    j+=1
value['.']='.'
index=0
while index<length:
    if value.has_key(n[index])==True:
        index+=1
        continue
    exit=1
    break
index=0
while index < length:
    if n[index] == '.':
        decimal=1
        break
    index+=1
ind=0
num=0
if exit==1:
    print "Invalid Input"
else:
    if decimal==1:
        while ind<index:
            if value[n[ind]]>=b:
                exit=1
                break
            mul=pow(b,index-ind-1)
            add=value[n[ind]]*mul
            num+=add
            ind+=1
        k=-1
        ind=index+1
        num2=float(0)
        while ind<length:
            if value[n[ind]]>=b:
                exit=1
                break
            mul=float(pow(b,k))
            add=float(value[n[ind]]*mul)
            num2=float(num2+add)
            ind+=1
            k-=1
        num=float(float(num)+float(num2))
    
    else:
        while ind<length:
            if value[n[ind]]>=b:
                exit=1
                break
            mul=pow(b,index-ind-1)
            add=value[n[ind]]*mul
            num+=add
            ind+=1
    if num>999999999 or num<-999999999:
        print "Invalid Input"
    elif neg==1:
        if decimal==0:
            print "-%d" %(num)
        else:
            print "-%f" %(num)
    elif neg==0:
        if decimal==1:
            print "%f" %(num)
        else:
            print "%d" %(num)
