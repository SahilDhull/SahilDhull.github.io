x = dlmread( 'new.csv', ',',0,0)
k=x(1,1);
if (k==0),
	x_train=(x'(1, 2:end))'
	y_train=(x'(2, 2:end))'
else,
	x_train=(x'(1, :))'
	y_train=(x'(2, :))'
end,

x2 = dlmread( 'new2.csv', ',',0,0)
k2=x2(1,1);
if (k==0),
	x_train2=(x2'(1, 2:end))'
	y_train2=(x2'(2, 2:end))'
else,
	x_train2=(x2'(1, :))'
	y_train2=(x2'(2, :))'
end,
