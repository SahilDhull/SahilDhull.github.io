#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<fcntl.h>
#include<pthread.h>

#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))


pthread_mutex_t lock,lock1,lac1[11001];

double *bal;
long long txn,cnt;

void *trans(void **arg){
	double **b=(double **)arg;
	while(1)
	{
		pthread_mutex_lock(&lock);
		int i=cnt;
		cnt++;
		pthread_mutex_unlock(&lock);
		//printf("%d\n", i);
		if(i>=txn){
			break;
		}
		pthread_mutex_lock(&lock1);
		pthread_mutex_lock(&lac1[(int)b[i][3]]);
		if (b[i][1]==4) {
			pthread_mutex_lock(&lac1[(int)b[i][4]]);
		}
		pthread_mutex_unlock(&lock1);
		/*long long m;
		for (size_t l = 0; l < 10000; l++) {
			m++;
		}*/
		switch((int)b[i][1]){
			case 1:
			bal[(int)b[i][3]]+=0.99*b[i][2];
			break;
			case 2:
			bal[(int)b[i][3]]-=1.01*b[i][2];
			break;
			case 3:
			bal[(int)b[i][3]]+=0.071*bal[(int)b[i][3]];
			break;
			case 4:
			bal[(int)b[i][3]]-=1.01*b[i][2];
			bal[(int)b[i][4]]+=0.99*b[i][2];
			pthread_mutex_unlock(&lac1[(int)b[i][4]]);
			break;
		}
		pthread_mutex_unlock(&lac1[(int)b[i][3]]);
	}
	pthread_exit(NULL);
}

int main(int argc, char **argv){
    int fd;
		struct timeval start, end;
    long long size1,size2,bytes_read=0;
    long long i,j,ctr;
    char *buff1, *buff2, *cbuff1, *cbuff2;

    bal=(double*)malloc(11000*sizeof(double));

    if(argc != 5){
            printf("Usage: %s <fileneme>\n", argv[0]);
            exit(-1);
    }

    int threads=atoi(argv[4]);
    txn=atoll(argv[3]);
    pthread_t t[threads];

    //reading acc.txt
    bytes_read=0;
    fd = open(argv[1], O_RDONLY);
    if(fd < 0){
           printf("Can not open file\n");
           exit(-1);
    }

    size1 = lseek(fd, 0, SEEK_END);
    if(size1 <= 0){
           perror("lseek");
           exit(-1);
    }

    if(lseek(fd, 0, SEEK_SET) != 0){
           perror("lseek");
           exit(-1);
    }

    buff1 = malloc(size1);
    if(!buff1){
           perror("mem");
           exit(-1);
    }

    do{
    	  long long bytes;
        cbuff1 = buff1 + bytes_read;
        bytes = read(fd, cbuff1, size1 - bytes_read);
        if(bytes < 0){
        	perror("read");
            exit(-1);
        }
        bytes_read += bytes;
	}while(size1 != bytes_read);
	close(fd);
	//acc.txt read


	//assigning data of acc.txt
	cbuff1=buff1;
	for(i=0;i<10000;i++){
		for(j=0;j<2;j++){
			if (j==1) {
				sscanf(cbuff1,"%lf",&bal[1001+i]);
				//printf("%f\n",bal[1001+i]);
			}
			char k='0';
			while (k!=' '&&k!='\n') {
				cbuff1++;
				if(cbuff1-buff1>=size1) break;
				k=(char)cbuff1[0];
			}
			cbuff1++;
		}
	}
	free(buff1);
	//all balances stored in array bal


	//to read txn.txt
	fd = open(argv[2], O_RDONLY);
	if(fd < 0){
		printf("Can not open file\n");
		exit(-1);
	}

	size2 = lseek(fd, 0, SEEK_END);
	if(size2 <= 0){
		perror("lseek");
		exit(-1);
	}

	if(lseek(fd, 0, SEEK_SET) != 0){
		perror("lseek");
		exit(-1);
	}

	buff2 = malloc(size2);
	if(!buff2){
		perror("mem");
		exit(-1);
	}

	bytes_read=0;
	do{
		long long bytes;
		cbuff2 = buff2 + bytes_read;
		bytes = read(fd, cbuff2, size2 - bytes_read);
		if(bytes < 0){
			perror("read");
			exit(-1);
		}
		bytes_read += bytes;
	}while(size2 != bytes_read);
	close(fd);
	//txn.txt read

	//assigning tha data of txn.txt properly
	double **a;
	a=(double *)malloc(txn*sizeof(double *));
	cbuff2=buff2;
	for(i=0;i<txn;i++){
		a[i]=(double *)malloc(5*sizeof(double));
		for(j=0;j<5;j++){
			sscanf(cbuff2,"%lf",&a[i][j]);
			char k='0';
			while(k!=' '&&k!='\n')
			{
				cbuff2=cbuff2+1;
				if(k=='\0'){
					break;
				}
				k=(char)cbuff2[0];
			}
			cbuff2++;
		}
	}
	free(buff2);
	//arrays bal,amt,ac1,ac2 filled


	for (ctr = 0; ctr < 11001; ctr++) {
		pthread_mutex_init(&lac1[ctr],NULL);
	}
	pthread_mutex_init(&lock,NULL);
	pthread_mutex_init(&lock1,NULL);

	gettimeofday(&start, NULL);

	for(ctr=0;ctr<threads;ctr++){
		if(pthread_create(&t[ctr],NULL,trans,a)!=0){
			perror("pthread_create");
            exit(-1);
		}
	}

	for(ctr=0; ctr < threads; ++ctr){
    	pthread_join(t[ctr], NULL);
	}

	gettimeofday(&end, NULL);

	for(ctr=0;ctr<10000;ctr++){
		int x=ctr+1001;
		printf("%d %.2f\n",x,bal[ctr+1001]);
	}

	//printf("Time taken = %ld microsecs\n", TDIFF(start, end));

}
