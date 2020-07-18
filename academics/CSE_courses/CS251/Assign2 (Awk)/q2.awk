#!/usr/bin/awk
BEGIN{
}
function second(time){
    split($1,inter,":")
    split(inter[3],sec,".")
    if(milstart[data]==""){
        milstart[data]=sec[2]
    }
    milend[data]=sec[2]
    return sec[1]
}

function extract(byte){
    split($9,bytes,"[:,]")
    for(i=bytes[1];i<bytes[2];i++){
        if(data_byte[data][i]==""){
            data_byte[data][i]++;
            total[data]++;
            xput[data]++;
        }
        else{
            total[data]++;
            retrans[data]++;
        }
    }
}

{
    A=$3
    split($5,B,":")
    data=$3"x"B[1]
    packet[data]++;
    if($8 ~ /seq/ && $9 ~ /:/){
        extract($9);
        data_packet[data]++;
    }
    else if(data_packet[data]==""){
        data_packet[data]=0;
    }
    this_sec=second($1)
    if(currentsec[data]==""){
        currentsec[data]=this_sec;
    }
    else if (this_sec>currentsec[data]||(this_sec==0&&currentsec[data]==59)){
        seconds[data]++;
        currentsec[data]=this_sec;
    }
}



END{
    for(i in packet){
        out[i]=0;
    }
    for(i in packet){
        if(out[i]!=1){
            split(i,array,"x")
            j=array[2]"x"array[1];
            if(total[i]==""){
                total[i]=0;
            }
            if(retrans[i]==""){
                retrans[i]=0;
            }
            if(total[j]==""){
                total[j]=0;
            }
            if(retrans[j]==""){
                retrans[j]=0;
            }
            out[i]=1;
            out[j]=1;
            milstart[i]="."milstart[i];
            milend[i]="."milend[i];
            msec[i]=milend[i]-milstart[i];
            if(msec[i]<0){
                msec[i]=milstart[i]-milend[i];
                msec[i]=1-msec[i];
                seconds[i]--;
            }
		milstart[j]="."milstart[j];
            milend[j]="."milend[j];
            msec[j]=milend[j]-milstart[j];
            if(msec[j]<0){
                msec[j]=milstart[j]-milend[j];
                msec[j]=1-msec[j];
                seconds[j]--;
            }
            seconds[i]+=msec[i];
            seconds[j]+=msec[j];
            if(data_packet[i]==""){
                data_packet[i]=0;
            }
            if(data_packet[j]==""){
                data_packet[j]=0;
            }
		xput1=((total[i]-retrans[i])/seconds[i]);
		xput2=((total[j]-retrans[j])/seconds[j]);
            print "Connection(A=",array[1],"B=",array[2],")";
            printf("A-->B #packets=%d,#datapackets=%d,#bytes=%d,#retrans=%d xput=%d bytes/sec",packet[i],data_packet[i],total[i],retrans[i],xput1)
            printf ("\nB-->A #packets=%d,#datapackets=%d,#bytes=%d,#retrans=%d xput=%d bytes/sec\n",packet[j],data_packet[j],total[j],retrans[j],xput2)
        }
    }
}

