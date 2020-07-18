#include <bits/stdc++.h>
using namespace std;

struct node{
    string str;
    int l;
    struct node *left;
    struct node *right;
};

void inorder(struct node* root){
    if(root==NULL) return;
    inorder(root->left);
    cout << root->str<<endl;
    inorder(root->right);
}

int ranktree(struct node *tree,string strin){
    int rank=0;
    struct node* bst=tree;
    while(bst){
        if(strin<bst->str){
            bst=bst->left;
        }
        else if(strin>bst->str){
            rank+=1+bst->l;
            bst=bst->right;
        }
        else{
            rank+=1+bst->l;
            return rank;
        }
        
    }
    return rank;
}


struct node* insert(struct node *tree,string strin){
    if(tree==NULL){
        tree=new struct node;
        tree->str=strin;
        tree->l=0;
        tree->left=NULL;
        tree->right=NULL;
    }
    else if(strin>tree->str){
        tree->right=insert(tree->right,strin);
    }
    else if(strin<tree->str){
        tree->l++;
        tree->left=insert(tree->left,strin);
    }
    return tree;
}

struct node* max(struct node* tree){
    struct node* x=tree;
    while(x->right!=NULL){
        x=x->right;
    }
    return x;
}

struct node* min(struct node* tree){
    struct node* x=tree;
    while(x->left!=NULL){
        x=x->left;
    }
    return x;
}

struct node* del(struct node *tree,string strin){
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
            struct node* insucc=min(tree->right);
            tree->str=insucc->str;
            tree->right=del(tree->right,insucc->str);
        }
        else if(tree->right==NULL){//only left child
            struct node* inpred=max(tree->left);
            tree->str=inpred->str;
            tree->l--;
            tree->left=del(tree->left,inpred->str);
        }
        else{//both child
            struct node* inpred;
            inpred=max(tree->left);
            tree->str=inpred->str;
            tree->l--;
            tree->left=del(tree->left,inpred->str);
        }
    }
    return tree;
}

int main() {
	int q;
	string que,in;
	cin>>q;
	struct node *tree=NULL;
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
