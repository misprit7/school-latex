function [X,Y]=euler(a,b,y0,N,fun)
h=(b-a)/N;
X=a:h:b;Y(:,1)=y0;
for i=1:N
   Y(:,i+1)=Y(:,i)+h*feval(fun,X(i),Y(:,i));
end
