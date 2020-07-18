#----------STEP-1----------
x = dlmread( 'train.csv', ',',0,0);
k=x(1,1);
if (k==0),
	x_train=(x'(1, 2:end))';
	y_train=(x'(2, 2:end))';
else,
	x_train=(x'(1, :))';
	y_train=(x'(2, :))';
end,
n_train=size(x_train)(1);
o=ones(n_train,1);
X_train=[o,x_train];
#----------STEP-2----------
w=rand(2,1);
#----------STEP-3----------
hold on;
plot(x_train,y_train,'.',x_train,X_train*w,'-');
# legend('x vs y','w^T*x` vs x');
title ("Plot with w");
print -dpdf "fig1.pdf";
close
#----------STEP-4----------
Xt=X_train';
p=Xt*X_train;
pi=inv(p);
p2=Xt*y_train;
w_direct=pi*p2;
hold on;
plot(x_train,y_train,'.',x_train,X_train*w_direct,'-');
title ("Plot with w direct");
print -dpdf "fig2.pdf";
close
#----------STEP-5----------
eta=0.00000001;
for nepoch = 1:2
	for j = 1:n_train
		x=x_train(j);
		y=y_train(j);
		xprime=[1,x]';
		w=w-eta*(w'*xprime-y)*xprime;
		if (rem(j,100)==0)
			hold on;
			plot(x_train,y_train,'.',x_train,X_train*w,'-');
		endif
	endfor
endfor
title ("Plot with different values of w");
print -dpdf "fig3.pdf";
close
#----------STEP-6----------
hold on;
plot(x_train,y_train,'.',x_train,X_train*w,'-');
title ("Plot with last value of w");
print -dpdf "fig4.pdf";
close
#----------STEP-7----------
x2 = dlmread( 'test.csv', ',',0,0);
k2=x2(1,1);
if (k==0),
	x_test=(x2'(1, 2:end))';
	y_test=(x2'(2, 2:end))';
else,
	x_test=(x2'(1, :))';
	y_test=(x2'(2, :))';
end,
n_test=size(x_test)(1);
o=ones(n_test,1);
X_test=[o,x_test];
y_pred1=X_test*w;
y_pred2=X_test*w_direct;

err1 = sqrt(mean((y_pred1 - y_test).^2))
err2 = sqrt(mean((y_pred2 - y_test).^2))

