#include<stdio.h>
#include<math.h>

int main(){
    int arr[10],sum,i;
    int n;
    scanf("%d ",&n);
    for(int i=0;i<n;i++){
        scanf("%d",&arr[i]);
    }
    sum=arr[0];
    for(i=1;i<n;i++){
        sum=sum^arr[i];
    }
    printf("sum=%d\n",sum);
}
