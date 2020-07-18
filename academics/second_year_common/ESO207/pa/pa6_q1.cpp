#include<bits/stdc++.h>
using namespace std;

int n;
list<int> *adj;
list<int> *adjt;
list<int> *adjl;
vector<pair<int,int>> label;
int *l;

void dfs(int v[],int i,stack<int> &Stack){
    list<int>::iterator j;
    v[i]=1;
    for(j = adj[i].begin(); j != adj[i].end(); ++j){
        if(!v[*j]){
            dfs(v,*j,Stack);
        }
    }
    Stack.push(i);
}

int dfs1(int v1[],int i,int min){
    list<int>::iterator j;
    v1[i]=1;
    //cout<<i<<" ";
    for(j = adjt[i].begin(); j != adjt[i].end(); ++j){
        if(!v1[*j]){
            if(*j<min){
                min=*j;
            }
            int min1=dfs1(v1,*j,min);
            if(min1<min){
                min=min1;
            }
        }
    }
    return min;
}

void dfs2(int v2[],int i,int lab){
    list<int>::iterator j;
    v2[i]=1;
    l[i]=lab;
    for(j = adjt[i].begin(); j != adjt[i].end(); ++j){
        if(!v2[*j]){
            //cout<<"adj= "<<*j<<endl;
            l[*j]=lab;
            dfs2(v2,*j,lab);
        }
    }
}

int main(){
    int i,j,x;
    cin>>n;
    int v[n],v1[n],id[n],v2[n];
    l=(int *)malloc(n*sizeof(int));
    adj = new list<int>[n];
    adjt = new list<int>[n];
    adjl = new list<int>[n];
    for(i=0;i<n;i++){
        v[i]=0;
        v1[i]=0;
        id[i]=-1;
        v2[i]=0;
    }
    for(i=0;i<n;i++){
        cin>>x;
        while(x!=-1){
            adj[i].push_back(x);
            cin>>x;
        }
    }
    stack<int> Stack;
    for(i=0;i<n;i++){
        if(v[i]==0){
            dfs(v,i,Stack);
        }
    }
    //transpose of the graph
    for(i=0;i<n;i++){
        list<int>::iterator j;
        for(j = adj[i].begin(); j != adj[i].end(); ++j){
            adjt[*j].push_back(i);
            //cout<<"j= "<<*j<<" i= "<<i<<endl;
        }
    }
    stack<int> Stack1=Stack;
    int k;
    while(!Stack.empty()){
        k=Stack.top();
        Stack.pop();
        if(v1[k]==0){
            int min=n;
            if(k<min){
                min=k;
            }
            id[k]=dfs1(v1,k,min);
            //cout<<"id[k]= "<<id[k]<<" for k= "<<k<<endl;
            label.push_back(make_pair(id[k],k));
            //cout<<endl;
        }
    }
    //cout<<"Graph printing ends here\n";
    sort(label.begin(), label.end());
    
    while(!Stack1.empty()){
        k=Stack1.top();
        Stack1.pop();
        if(v2[k]==0){
            for(j=0;j<label.size();j++){
                if(k==label[j].second){
                    break;
                }
            }
            dfs2(v2,k,j);
        }
    }
    int lsize=label.size();
    //cout<<"Labels finally assigned are: \n";
    /*for(i=0;i<n;i++){
        cout<<i<<" "<<l[i]<<endl;
    }*/
    list<int>::iterator it;
    for(i=0;i<n;i++){
        for(it = adj[i].begin(); it != adj[i].end(); ++it){
            j=*it;
            if(l[j]!=l[i]){
                adjl[l[i]].push_back(l[j]);
                adjl[l[i]].unique();
                adjl[l[i]].sort();
            }
        }
    }
    cout<<lsize<<endl;
    for(i=0;i<lsize;i++){
        for(it = adjl[i].begin(); it != adjl[i].end(); ++it){
            cout<<*it<<" ";
        }
        cout<<"-1"<<endl;
    }
    
}
