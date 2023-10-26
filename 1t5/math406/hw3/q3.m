alpha=1000;
a=0;b=pi;
f=@(x,y) -alpha*(y-sin(x))+cos(x);
y0=1;
N=20;
sol = @(x) sin(x)+exp(-alpha*x);

[X,Y] = ode23(f,[a,b],y0,odeset('AbsTol',0.0001));

plot(X,Y,'-o');
disp(size(X))

return

hold on;
X = a:0.001:b;
Y = sol(X);
plot(X,Y,"DisplayName",'Exact');

[Xe, Ye] = impEuler(a,b,y0,ceil((b-a)/(1/500)),f);
plot(Xe,Ye,"DisplayName",'Improved Euler');
hold off;
legend();

return

method = {@trapRule, @BackEuler};
hold on;
X = a:0.001:b;
Y = sol(X);
plot(X,Y,"DisplayName",'Exact');
for i=1:2
   m = method{i};
   [X,Y] = m(a,b,y0,N,f);
   plot(X,Y,"DisplayName",char(m));
end
hold off;
legend();

function [X,Y]=impEuler(a,b,y0,N,fun)
   h=(b-a)/N;
   X=a:h:b;Y(:,1)=y0;
   for i=1:N
      Yt=Y(:,i)+h*feval(fun,X(i),Y(:,i));
      Y(:,i+1)=Y(:,i)+h/2*(feval(fun,X(i),Y(:,i))+feval(fun,X(i+1),Yt));
   end
end

function [X,Y]=trapRule(a,b,y0,N,fun)
h=(b-a)/N;hh=h/2;m=length(y0);
ep=sqrt(eps);maxit=15;I=eye(m);tol=1e-8;
X=a:h:b;Y(:,1)=y0;
   for i=1:N
      Y1 = Y(:,i); %+ h*feval(fun,X(i),Y(:,i));
      % Y1 = Y(:,i) + hh*(feval(fun,X(i),Y(:,i))+feval(fun,X(i)+h,Y1));
      R1 = (Y1 - Y(:, i) - h/2*(feval(fun, X(i)+h,Y1)+feval(fun,X(i),Y(:,i))));
      for it = 1:maxit 
        for j = 1:m
          D(:,j) = (feval(fun,X(i)+h,Y1+ep*I(:,j))-feval(fun,X(i)+h,Y1-ep*I(:,j)))/(2*ep);
        end
        J  = I - h*D;
        dY = -J\R1;
        Y1 = Y1 + dY;
        R1 = (Y1 - Y(:, i) - h/2*(feval(fun, X(i)+h,Y1)+feval(fun,X(i),Y(:,i))));
        RS(it)=norm(R1,2);
        if norm(R1,2) < tol*norm(Y1,2);break;end
      end
      %plot(1:it,log10(RS));pause;RS=[];
      if it >=maxit,
          msg=[' WARNING: in step ',num2str(i),' Newton Iteration did not converge in ',num2str(maxit),' iterations ']
      end
      Y(:,i+1)=Y(:,i)+hh*(feval(fun,X(i)+h,Y1)+feval(fun,X(i),Y(:,i)));
   end
end

function [X,Y]=BackEuler(a,b,y0,N,fun)
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
end

