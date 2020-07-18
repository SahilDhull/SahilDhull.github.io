#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define CUDA_ERROR_EXIT(str) do{\
    cudaError err = cudaGetLastError();\
    if( err != cudaSuccess){\
        printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
        exit(-1);\
    }\
}while(0);

__global__ void Xor(int *dX,int num)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if(num%2==0){
        if(i>num/2||i==0)
        return;
        dX[i]=dX[i]^dX[i+num/2];
    }
    if(num%2!=0){
        if(i>num/2||i==0)
        return;
        dX[i]=dX[i]^dX[i+num/2+1];
    }
}

int main(int argc, char **argv)
{
    int ctr;
    int *hX,*S,*dX;

    /*Allocate memory on the host (CPU) */

    if(argc!=3){
        printf("Incorrect number of arguments\n");
        exit(1);
    }

    int n = atoi(argv[1]);
    int seed = atoi(argv[2]);
    int size = (n+1) * sizeof(int);

    hX = (int *) malloc(size);
    if(!hX){
        perror("malloc");
        exit(-1);
    }

    S= (int *)malloc(2*sizeof(int));
    //printf("%d\n",n);
    srand(seed);
    hX[0]=0;
    for(ctr=1; ctr <= n; ++ctr){
        hX[ctr] = random()/*%10000*/;
        //printf("%d\n",hX[ctr]);
    }

    /*Allocate memory on the device (GPU) */

    cudaMalloc(&dX,  size);
    CUDA_ERROR_EXIT("cudaMalloc");

    /*Copy hX --> dX */

    cudaMemcpy(dX, hX, size, cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("memcpy1");

    int blocks;

    /*Invoke the kernel*/

    int num=n;
    while(num>1){
        blocks=(num+1023)>>10;
        //printf("num= %d\n",num);
        Xor<<<blocks, 1024>>>(dX, num);
        CUDA_ERROR_EXIT("kernel invocation");
        num=num/2+num%2;
    }

    /*Copy back results*/
    cudaMemcpy(S, dX, 2*sizeof(int), cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");

    printf("%d\n", S[1]);

    free(hX);
    free(S);
    cudaFree(dX);
}
