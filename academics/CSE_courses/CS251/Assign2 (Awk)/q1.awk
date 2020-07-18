#!/usr/bin/awk
BEGIN{
    flag_cmnt1=0
    flag_cmnt2=0
    flag_str=0
    cnt_cmnt=0
    cnt_str=0
}
{
    flag_cmnt2=0;
    if(flag_cmnt1==1){
        cnt_cmnt++;
    }
    for(i=1;i<=NF;i++)
    {
        if($i ~ /\/\*/ && flag_str==0 && flag_cmnt1==0 && flag_cmnt2==0){
            flag_cmnt1=1;
            cnt_cmnt++;
        }
        if($i ~ /\*\// && flag_cmnt1==1){
            flag_cmnt1=0;
        }
        if($i ~ /\"/ && flag_cmnt1==0 && flag_cmnt2==0){
            if($i ~ /\\"/){
                
            }
            else if(flag_str==1){
                cnt_str++;
                flag_str=0;
            }
            else{
                flag_str=1;
            }
        }
        if($i ~ /\/\// && flag_cmnt1==0 && flag_cmnt2==0 && flag_str==0){
            cnt_cmnt++;
            next;
        }
    }
}
END{
    print cnt_cmnt " " cnt_str
}

