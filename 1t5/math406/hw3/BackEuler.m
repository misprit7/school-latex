%Backward Euler Method - Implicit
function [X,Y]=BackEuler(fun,a,b,y0,N)
h=(b-a)/N;hh=h/2;m=length(y0);
ep=sqrt(eps);maxit=15;I=eye(m);tol=1e-8;
X=a:h:b;Y(:,1)=y0;
for i=1:N
   Y1 = Y(:,i); %+ h*feval(fun,X(i),Y(:,i));
   %Y1 = Y(:,i) + hh*(feval(fun,X(i),Y(:,i))+feval(fun,X(i)+h,Y1));
   R1 = (Y1-Y(:,i)-h*feval(fun,X(i)+h,Y1));
   for it = 1:maxit 
     for j = 1:m
       D(:,j) = (feval(fun,X(i)+h,Y1+ep*I(:,j))-feval(fun,X(i)+h,Y1-ep*I(:,j)))/(2*ep);
     end
     J  = I - h*D;
     dY = -J\R1;
     Y1 = Y1 + dY;
     R1 = (Y1-Y(:,i)-h*feval(fun,X(i)+h,Y1));
     RS(it)=norm(R1,2);
     if norm(R1,2) < tol*norm(Y1,2);break;end
   end
   %plot(1:it,log10(RS));pause;RS=[];
   if it >=maxit,
       msg=[' WARNING: in step ',num2str(i),' Newton Iteration did not converge in ',num2str(maxit),' iterations ']
   end
   Y(:,i+1)=Y(:,i)+h*feval(fun,X(i)+h,Y1);
end

