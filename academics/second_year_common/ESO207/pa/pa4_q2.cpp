#include<bits/stdc++.h>
using namespace std;


unsigned long hashf(string str){
    int j= str.length();
    int i;
    unsigned long num=5381;
    for(i=j-1;i>=0;i--){
        num=num*33+str[i];//num = ((num << 5) + num) + str[i];//num=num*33+str[i]
        num=num%100000000;
    }
    return num;
}

int main(){
    int n;
    int max=0;
    string out;
	vector<long long> count(100000000,0);
    cin>>n;
    while(n--){
    	string strin;
        cin>>strin;
        unsigned long k=hashf(strin);
        count[k]++;
        if(count[k]>max){
        	max=count[k];
            out=strin;
        }
    }
    cout<<out;
}
