#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>
void* find_max_prime(void *arg);
#define SEED 0x7457

#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))
struct thread_param{
                       pthread_t tid;
                       int *array;
                       int size;
                       int skip;
			int thread_ctr;	
                       int max;
                       int max_index;
};



void* find_max_prime(void *arg){
  struct thread_param *param = (struct thread_param *) arg;
  int ctr,i;
  param->max=0;
  param->max_index=0;
  ctr=param->thread_ctr;
  while(ctr < param->size)
  {
    int num = param->array[ctr];
    int isprime=0;
    for(int i=2;i<=sqrt(num);i++){
        isprime=1;
        if(num%i==0){
        	isprime=0;
        	break;
        }
    }
    if (isprime==1)
    {
      if(num>param->max)
      {
        param->max=num;
        param->max_index=ctr;
      }
    }
    ctr+=param->skip;
  }
}

int main(int argc, char **argv)
{
  struct thread_param *params;
  struct timeval start, end;
  int *a, num_elements, ctr, num_threads;
  int max;
  int max_index;

  if(argc !=3)
           USAGE_EXIT("not enough parameters");

  num_elements = atoi(argv[1]);
  if(num_elements <=0)
          USAGE_EXIT("invalid num elements");

  num_threads = atoi(argv[2]);
  if(num_threads <=0 || num_threads > MAX_THREADS){
          USAGE_EXIT("invalid num of threads");
  }
  a = malloc(num_elements * sizeof(int));
  if(!a){
          USAGE_EXIT("invalid num elements, not enough memory");
  }
  srand(time(NULL));
  for(ctr=0; ctr<num_elements; ctr++)
        a[ctr] = random();


  params = malloc(num_threads * sizeof(struct thread_param));
  bzero(params, num_threads * sizeof(struct thread_param));

  gettimeofday(&start, NULL);
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        param->size = num_elements;
        param->skip = num_threads;
        param->array = a;
	param->thread_ctr = ctr;
        if(pthread_create(&param->tid, NULL, find_max_prime, param) != 0){
          perror("pthread_create");
          exit(-1);
        }

  }
  for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *param = params + ctr;
        pthread_join(param->tid, NULL);
        if(ctr == 0 || (ctr > 0 && param->max > max)){
             max = param->max;
             max_index = param->max_index;
        }
  }
  if (max==0)
  {
    printf("NONE IS PRIME\n");
  }
  else
  {
    printf("MAX PRIME=%d\n",max );
  }
  gettimeofday(&end, NULL);
  printf("Time taken = %ld microsecs\n", TDIFF(start, end));
  free(a);
  free(params);
}


