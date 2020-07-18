#include<bits/stdc++.h>
using namespace std;

int main(){
    int a,b,w,n,m,i,j;
    cin>>n>>m;
    int p[n],c[n];
    int d[n];
    int e[n][n];
    for(i=0;i<n;i++){
        for(j=0;j<n;j++){
            e[i][j]=0;
        }
    }
    for(i=1;i<n;i++){
        d[i]=1000000;
        p[i]=1000000;
        c[i]=0;
    }
    d[0]=0;
    p[0]=0;
    c[0]=0;
    while(m--){
        cin>>a>>b>>w;
        e[a][b]=w;
        e[b][a]=w;
    }
    int sum=0;
    
    for(i=1;i<n;i++){
        int min=1000000;
        int u;
        for(j=0;j<n;j++){
            if(c[j]==0&&d[j]<min){
                min=d[j];
                u=j;
            }
        }
        c[u]=1;
        for(j=0;j<n;j++){
            if(e[u][j]!=0 && c[j]==0 && e[u][j]<d[j]){
                p[j]=u;
                d[j]=e[u][j];
            }
        }
    }
    for(i=1;i<n;i++){
        j=p[i];
        sum+=e[i][j];
    }
    
    cout<<sum;
}
