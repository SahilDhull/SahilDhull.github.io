#include<bits/stdc++.h>
using namespace std;

int main(){
    int a,b,w,n,m,i,j;
    cin>>n>>m;
    int p[n];
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
    }
    d[0]=0;
    while(m--){
        cin>>a>>b>>w;
        e[a][b]=w;
    }
    for(int k=1;k<n;k++){
        for(i=0;i<n;i++){
            for(j=0;j<n;j++){
                if(e[i][j]!=0){
                    //code to relax
                    if(d[i]>d[j]+e[i][j]){
                        d[i]=d[j]+e[i][j];
                        p[i]=j;
                    }
                    if(d[j]>d[i]+e[i][j]){
                        d[j]=d[i]+e[i][j];
                        p[j]=i;
                    }
                }
            }
        }
    }
    if(d[n-1]<1000000){
        cout<<d[n-1]<<"\n";
    }
    else{
        cout<<"-1\n";
    }
}
