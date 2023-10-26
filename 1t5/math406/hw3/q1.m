
a=0;b=1;
f=@(x,y) x./(1.+x.^2).*y;
y0=1;
yexact = @(x) (1+x^2)^(1/2);

method = {@euler, @impEuler, @trapRule, @RK4, @BackEuler};
h=[2^(-2),2^(-3),2^(-4)];
T = zeros(10,3);
for i=1:5
   m = method{i};
   for j=1:3
      [X,Y] = feval(m,a,b,y0,(b-a)/h(j),f);
      T(i*2-1,j)=abs((yexact(1)-Y(1,end)));
      if j>1
         T(i*2,j)=log(T(i*2-1,j-1)/T(i*2-1,j))/log(2);
      end
   end
end

disp(T)

return

a=0;b=1/2;
f=@(x,y) 10*(-1-3^(1/2)*1i).*y;
y0=1;

% for h=[2^(-2), 2^(-3), 2^(-4)]
% h = 2^(-10);

h= 0;
lambda = 10*(-1-3^(1/2)*1i);
% while abs(1+h*lambda+(h*lambda)^2/2)<=1
while abs(1+h*lambda)<=1
   h=h+0.001;
end
disp(h)
% [Xm,Ym] = impEuler(a,b,y0,floor((b-a)/h),f);
% [Xs,Ys] = impEuler(a,b,y0,floor((b-a)/(h/2)),f);
% [Xb,Yb] = impEuler(a,b,y0,floor((b-a)/(h*2)),f);
[Xm,Ym] = euler(a,b,y0,floor((b-a)/h),f);
[Xs,Ys] = euler(a,b,y0,floor((b-a)/(h/2)),f);
[Xb,Yb] = euler(a,b,y0,floor((b-a)/(h*2)),f);
Xr = a:(b-a)/100:b;
Yr = exp(10*(-1-3^(1/2)*1i).*Xr);
hold on;
plot(Xm,Ym, "DisplayName", "h=hm");
plot(Xs,Ys, "DisplayName", "h<hm");
plot(Xb,Yb, "DisplayName", "h>hm");
plot(Xr,Yr, "DisplayName", "exact");
legend();
hold off;
% end

function [X,Y]=euler(a,b,y0,N,fun)
   h=(b-a)/N;
   X=a:h:b;Y(:,1)=y0;
   for i=1:N
      Y(:,i+1)=Y(:,i)+h*feval(fun,X(i),Y(:,i));
   end
end

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

function [X,Y]=RK4(a,b,y0,N,fun)
h=(b-a)/N;hh=h/2;m=length(y0);
ep=sqrt(eps);maxit=15;I=eye(m);tol=1e-8;
X=a:h:b;Y(:,1)=y0;
   for i=1:N
      Y1 = Y(:,i); %+ h*feval(fun,X(i),Y(:,i));
      % Y1 = Y(:,i) + hh*(feval(fun,X(i),Y(:,i))+feval(fun,X(i)+h,Y1));
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
      m1=feval(fun,X(i),Y(:,i));
      m2=feval(fun,X(i)+h/2,Y(:,i)+h/2*m1);
      m3=feval(fun,X(i)+h/2,Y(:,i)+h/2*m2);
      m4=feval(fun,X(i)+h,Y(:,i)+h*m3);
      Y(:,i+1)=Y(:,i)+h/6*(m1+2*m2+2*m3+m4);
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
