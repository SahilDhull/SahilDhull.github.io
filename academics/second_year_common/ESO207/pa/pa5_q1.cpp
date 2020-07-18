#include<bits/stdc++.h>
using namespace std;

typedef struct node{
    int val;
    struct node * next;
}node;

void del(node *v[],int y,int x){
    node *temp=v[y];
    while(temp->next){
        node *prev=temp;
        temp=temp->next;
        if(temp->val==x){
            if(temp->next==NULL){
                prev->next=NULL;
                return ;
            }
            else{
                temp->val=temp->next->val;
                temp->next=temp->next->next;
                return ;
            }
        }
    }
    if(temp->next==NULL && temp->val==x){
        temp=NULL;
        return ;
    }
}

int check(node *v[],int x, int y){
    node* temp=v[x];
    while(temp->next){
        if(temp->val==y){
            return 1;
        }
        temp=temp->next;
    }
    if(temp->val==y){
        return 1;
    }
    return 0;
}

int main(){
    int n,op,x,y,k;
    string in;
    cin>>n;
    node *v[n+1];
    node *temp;
    for(int i=0;i<=n;i++){
        v[i]=(node *)malloc(sizeof(node));
        v[i]->val=0;
        v[i]->next=NULL;
    }
    cin>>op;
    while(op--){
        cin>>in;
        if(in == "addnode"){
            cin>>x;
            v[x]->val=x;
        }
        else if (in=="addlink"){
            cin>>x>>y;
            if(check(v,x,y)){
            }
            else{
                temp=v[x];
                while(temp->next){
                    temp=temp->next;
                }
                temp->next=(node *)malloc(sizeof(node));
                temp->next->val=y;
                temp->next->next=NULL;
                temp=v[y];
                while(temp->next){
                    temp=temp->next;
                }
                temp->next=(node *)malloc(sizeof(node));
                temp->next->val=x;
                temp->next->next=NULL;
            }
        }
        else if(in=="delnode"){
            cin>>x;
            v[x]->val=0;
            temp=v[x]->next;
            while(temp){
                int tval= temp->val;
                temp->val=0;
                del(v,tval,x);
                temp=temp->next;
            }
            v[x]->next=NULL;
        }
        else if(in=="remlink"){
            cin>>x>>y;
            del(v,x,y);
            del(v,y,x);
        }
    }
    cin>>k;
    while(k--){
        cin>>x;
        if(v[x]->val==0){
            cout<<"not in network"<<endl;
        }
        else if(v[x]->next==NULL){
            cout<<"no connections\n";
        }
        else{
            temp = v[x];
            while(temp->next){
                cout<<temp->next->val<<" ";
                temp=temp->next;
            }
            cout<<endl;
        }
    }
}

