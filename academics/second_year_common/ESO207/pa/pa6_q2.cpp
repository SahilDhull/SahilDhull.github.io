#include <bits/stdc++.h>
using namespace std;

vector<int> *adj;
vector<int> low;
vector<int> art;
vector<int> p;
vector<int> v;
vector<int> t;

void dfs(int i,int index){
    v[i]=1;
    index++;
    t[i]=index;
    low[i]=index;
    int c=0;
    int j;
    for(j=0;j<adj[i].size();j++){
        int y=adj[i][j];
        if(v[y]==0){
            c++;
            p[y]=i;
            dfs(y,index);
            if(low[y]<low[i]){
                low[i]=low[y];
            }
            if(p[i]!=-1 && low[y]>=t[i])
                art[i]=1;
            if(p[i]==-1 && c>1)
                art[i]=1;
        }
        else if(y!=p[i]){
            if(t[y]<low[i]){
                low[i]=t[y];
            }
        }
    }
}

int main() {
	int n,m,i,j,x,y;
	cin>>n>>m;
	int index=0;
	adj = new vector<int>[n];
	for(i=0;i<n;i++){
	    low.push_back(0);
	    art.push_back(0);
	    p.push_back(-1);
	    v.push_back(0);
	    t.push_back(0);
	}
	while(m--){
	    cin>>x>>y;
	    adj[x].push_back(y);
	    adj[y].push_back(x);
	}
	dfs(0,0);
	for(i=0;i<n;i++){
	    //cout<<i;
	    if(art[i]==1){
	        cout<<i<<endl;
	    }
	}
	return 0;
}
