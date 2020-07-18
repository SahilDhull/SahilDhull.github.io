#--------------------1--------------------
num_samples <- 50000
data <- rexp(num_samples, 0.2)
sorted=sort(data)
x <- data.frame(X = seq(1, num_samples , 1), Y = sorted)
plot(x)
#--------------------2--------------------
slice <- function(x, n) split(x, as.integer((seq_along(x) - 1) / n))
value<-slice(data, 100)
#--------------------3--------------------
plot_graph<-function(x,k)
{
	pdata <- rep(0, 100);
	for(i in 1:100){
    	val=round(x[[k]][i], 0);
    	if(val <= 100){
       		pdata[val] = pdata[val] + 1/100; 
    	}
	}
	cdata <- rep(0, 100)
	cdata[1]<-pdata[1]
	for(i in 2:100){
	    cdata[i] = cdata[i-1] + pdata[i]
	}
	plot(c(0:99), pdata,"l",xlab="X",ylab="PDF(X)")
	plot(c(0:99), cdata,"o", col="blue",xlab="X",ylab="CDF(X)")
}
plot_graph(value,1)
plot_graph(value,2)
plot_graph(value,3)
plot_graph(value,4)
plot_graph(value,5)
m=rep(0,500)
s=rep(0,500)
for(i in 1:500){
	m[i]=mean(value[[i]])
	s[i]=sd(value[[i]])
}
m[1];s[1]
m[2];s[2]
m[3];s[3]
m[4];s[4]
m[5];s[5]
#--------------------4--------------------
tab <- table(round(m,digits=1))
plot(tab, "h", xlab="Mean Values", ylab="Frequency(Mean)")
pm <- rep(0, 20);
for(i in 1:500){
    val=round(m[i], 1);
    if(val <= 20){
       pm[val] = pm[val] + 1/500; 
    }
}
plot(c(0:19), pm,"l",xlab="Mean",ylab="PDF(Mean)")
cm=rep(0,20)
cm[1]=pm[1]
for(i in 2:20){
	cm[i]=cm[i-1]+pm[i]
}
plot(c(0:19), cm,"o", col="blue",xlab="Mean",ylab="CDF(Mean)")
#--------------------5--------------------
mm=mean(m)
mm
msd=sd(m)
msd
#--------------------6--------------------
md=mean(data)
md
sdd=sd(data)
sdd
#-------------------END-------------------
