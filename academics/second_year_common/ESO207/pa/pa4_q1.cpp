#include <bits/stdc++.h>
#include <string>
using namespace std;

typedef struct node{
    string str;
    int l,ht;
    struct node *left;
    struct node *right;
}avl;

int height(avl *tree){
    int lh,rh;
    if(tree==NULL)
        return 0;
    if(tree->left==NULL)
        lh=0;
    else
        lh=1+tree->left->ht;
    if(tree->right==NULL)
        rh=0;
    else
        rh=1+tree->right->ht;
    if(lh>rh)
        return lh;
    return rh;
}

int bf(avl *tree){
    int lh,rh;
    if(tree==NULL)
        return 0;
    if(tree->left==NULL)
        lh=0;
    else
        lh=1+tree->left->ht;
    if(tree->right==NULL)
        rh=0;
    else
        rh=1+tree->right->ht;
    return (lh-rh);
}

avl *rotleft(avl *tree){
    avl* b;
    int l1,l2;
    b=tree->right;
    tree->right=b->left;
    b->left=tree;
    tree->ht=height(tree);
    b->ht=height(b);
    //update value of l
    b->l+=tree->l+1;
    return (b);
}

avl *rotright(avl *tree){
    avl* b;
    int temp = tree->l;
    b=tree->left;
    tree->left=b->right;
    b->right=tree;
    tree->ht=height(tree);
    b->ht=height(b);
    //update value of l
    tree->l=temp-1-b->l;
    return (b);
}

avl *LR_rotation(avl *tree){
    tree->left=rotleft(tree->left);
    tree=rotright(tree);
    return tree;
}

avl *RL_rotation(avl *tree){
    tree->right=rotright(tree->right);
    tree=rotleft(tree);
    return tree;
}

void inorder(avl *root){
    if(root==NULL) return;
    inorder(root->left);
    cout << root->str<<endl;
    inorder(root->right);
}

int ranktree(avl *tree,string strin){
    int rank=0;
    avl *x=tree;
    while(x){
        if(strin<x->str){
            x=x->left;
        }
        else if(strin>x->str){
            rank+=1+x->l;
            x=x->right;
        }
        else{
            rank+=1+x->l;
            return rank;
        }
    }
    return rank;
}

avl* insert(avl *tree,string strin){
    if(tree==NULL){
        tree=new avl;
        tree->str=strin;
        tree->l=0;
        tree->ht=1;
        tree->left=NULL;
        tree->right=NULL;
    }
    else if(strin>tree->str){
        tree->right=insert(tree->right,strin);
        tree->right->ht=height(tree->right);
        if(bf(tree)==-2){
            if(strin>tree->right->str){
                tree=rotleft(tree);
            }
            else{
                tree=RL_rotation(tree);
            }
        }
    }
    else if(strin<tree->str){
        tree->l++;
        tree->left=insert(tree->left,strin);
        tree->left->ht=height(tree->left);
        if(bf(tree)==2){
            if(strin<tree->left->str){
                tree=rotright(tree);
            }
            else{
                tree=LR_rotation(tree);
            }
        }   
    }
    tree->ht=height(tree);
    return tree;
}

avl* max(avl* tree){
    avl* x=tree;
    while(x->right!=NULL){
        x=x->right;
    }
    return x;
}

avl* min(avl* tree){
    avl* x=tree;
    while(x->left!=NULL){
        x=x->left;
    }
    return x;
}

avl* del(avl *tree,string strin){
    if(tree==NULL)
        return NULL;
    if(strin<tree->str){
        tree->l--;
        tree->left=del(tree->left,strin);
    }
    else if(strin>tree->str){
        tree->right=del(tree->right,strin);
    }
    else{
        if(tree->left==NULL && tree->right==NULL){//no child
            tree=NULL;
        }
        else if(tree->left==NULL){//only right child
            avl* insucc=min(tree->right);
            tree->str=insucc->str;
            tree->right=del(tree->right,insucc->str);
        }
        else if(tree->right==NULL){//only left child
            avl* inpred=max(tree->left);
            tree->str=inpred->str;
            tree->l--;
            tree->left=del(tree->left,inpred->str);
        }
        else{//both child
            avl* inpred =max(tree->left);
            tree->str=inpred->str;
            tree->l--;
            tree->left=del(tree->left,inpred->str);
        }
    }
    if(tree==NULL)
        return tree;
    if(bf(tree)==-2){
        if(bf(tree->right)<=0){
            tree=rotleft(tree);
        }
        else{
            tree=RL_rotation(tree);
        }
    }
    if(bf(tree)==2){
        if(bf(tree->left)>=0){
            tree=rotright(tree);
        }
        else{
            tree=LR_rotation(tree);
        }
    }
    return tree;
}

int main() {
	int q;
	string que,in;
	cin>>q;
	avl *tree=NULL;
	while(q--){
	    cin>>que;
	    if(que=="learn"){
	        cin>>in;
	        tree=insert(tree,in);
	    }
	    else if(que=="findrank"){
	        cin>>in;
	        int r=ranktree(tree,in);
	        cout<<r<<endl;
	    }
	    else if(que=="forget"){
	        cin>>in;
	        int r=ranktree(tree,in);
	        cout<<r<<endl;
	        tree=del(tree,in);
	    }
	}
	
	return 0;
}
