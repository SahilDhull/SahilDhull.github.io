#include <bits/stdc++.h>
using namespace std;

vector <string> table;

void init(){
    int i;
    string a,A;
    table.resize(4095);
    for(i=0;i<26;i++){
        a = 97+i;
        A=65+i;
        table[i]=A;
        table[i+26]=a;
    }
    for (int i = 0; i < 10; i++) {
        table[52+i]=48+i;
    }
    table[62]=32;
}


int main() {
	int o;
	int n=0;
	init();
	cin>>o;
	string c;
	string str;
	cout<<table[o];
	while(n!=-1){
	    cin>>n;
	    if(n==-1){
	        break;
	    }
	    str=table[n];
	    if(n>table.size()){
	        str=table[o];
	        str.append(c);
	    }
	    else{
	        string k = c;
	        k.append(str,0,1);
	        table.push_back(k);
	    }
	    cout<<c;
	    c=str;
	    o=n;
	   // cout<<table[n];
	}
	
	return 0;
}
