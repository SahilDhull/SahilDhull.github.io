#include <bits/stdc++.h>
using namespace std;
vector<string> v ;
void insert(string in){
    v.push_back(in);
    int n=v.size();
    for(int k=n-1;k>1;k/=2){
        if(v[k]<v[k/2]){
            swap(v[k],v[k/2]);
        }
        else{
            break;
        }
    }
}

void del(){
    string last;
    last=v[v.size()-1];
    v.pop_back();
    int n=v.size();
    int i=1,left=2,right=3;
        cout<<v[i]<<endl;
    v[i]=last;
    
    while(left<=n-1){
        if(v[i]<=v[left] && v[i]<=v[right]){
        	return;
        }
        if(v[right]>=v[left]){
            std::swap(v[i],v[left]);
            i=left;
        }
        else{
            std::swap(v[i],v[right]);
            i=right;
        }
        left=2*i;
        right=left+1;
    }
}

int main() {
	int q;
	string str,in;
	cin>>q;
	v.push_back("zzzzzzzzzzzzzzzzzzzzzz");
	while(q--){
	    cin>>str;
	    if(str=="learn"){
	        cin>>in;
	        insert(in);
	    }
	    else if(str=="reportsmallest"){
	      //  if(flag==0){
	            cout<<v[1]<<endl;
	      
	    }
	    else if(str=="forgetsmallest"){
	        del();
	    }
	}
	return 0;
}
