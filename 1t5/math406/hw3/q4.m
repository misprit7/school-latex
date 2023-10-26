r = 1;
% fxr = @(theta,x) -r*sin(theta);
% fyr = @(theta,y) r*cos(theta);
fx = @(x,y) -y;
fy = @(x,y) x;
x0 = r;
y0 = 0;
h=0.02;
a=0;b=120;

method = {@euler, @trapRule, @BackEuler};
for i=1:3
   figure;
   m=method{i};
   N=(b-a)/h;
   [thetax,X,Y]=m(a,b,x0,y0,N,fx,fy);
   plot(X,Y);
   axis equal;
   title(char(m));
end

% Exact
% method = {@euler, @trapRule, @BackEuler};
% for i=1:3
%    figure;
%    m=method{i};
%    N=(b-a)/h;
%    [thetax,X]=m(a,b,x0,N,fx);
%    [thetay,Y]=m(a,b,y0,N,fy);
%    plot(X,Y);
%    axis equal;
% end

function [theta,X,Y]=euler(a,b,x0,y0,N,fx,fy)
   h=(b-a)/N;
   theta=a:h:b;X(:,1)=x0;Y(:,1)=y0;
   for i=1:N
      X(:,i+1)=X(:,i)+h*feval(fx,X(:,i),Y(:,i));
      Y(:,i+1)=Y(:,i)+h*feval(fy,X(:,i),Y(:,i));
   end
end

function [theta,X,Y]=trapRule(a,b,x0,y0,N,fx,fy)
   h=(b-a)/N;hh=h/2;m=length(y0);
   ep=sqrt(eps);maxit=15;I=eye(m);tol=1e-8;
   theta=a:h:b;X(:,1)=x0;Y(:,1)=y0;
   for i=1:N
     X1 = X(:,i);
     Y1 = Y(:,i);
     % R1 = (Y1 - Y(:, i) - h/2*(feval(fy, X(:,i)+h,Y1)+feval(fy,X(:,i),Y(:,i))));
     % R2 = (X1 - X(:, i) - h/2*(feval(fx, X(:,i),Y1+h)+feval(fx,X(:,i),Y(:,i))));
     R1 = (Y1 - Y(:, i) - h/2*(feval(fy, X1,Y1)+feval(fy,X(:,i),Y(:,i))));
     R2 = (X1 - X(:, i) - h/2*(feval(fx, X1,Y1)+feval(fx,X(:,i),Y(:,i))));
     for it = 1:maxit 
        for j = 1:m
          Dy(:,j) = (feval(fy,X1,Y1+ep*I(:,j))-feval(fy,X1,Y1-ep*I(:,j)))/(2*ep);
          Dx(:,j) = (feval(fx,X1+ep*I(:,j),Y1)-feval(fx,X1-ep*I(:,j),Y1))/(2*ep);
        end
        Jy  = I - h*Dy;
        Jx  = I - h*Dx;
        dY = -Jy\R1;
        dX = -Jx\R2;
        Y1 = Y1 + dY;
        X1 = X1 + dX;
        R1 = (Y1 - Y(:, i) - h/2*(feval(fy, X1,Y1)+feval(fy,X(:,i),Y(:,i))));
        R2 = (X1 - X(:, i) - h/2*(feval(fx, X1,Y1)+feval(fx,X(:,i),Y(:,i))));
        if norm([R1,R2],2) < tol*norm([Y1,X1],2);break;end
      end
      %plot(1:it,log10(RS));pause;RS=[];
      if it >=maxit,
          msg=[' WARNING: in step ',num2str(i),' Newton Iteration did not converge in ',num2str(maxit),' iterations ']
      end
      Y(:,i+1)=Y(:,i)+hh*(feval(fy,X1,Y1)+feval(fy,X(:,i),Y(:,i)));
      X(:,i+1)=X(:,i)+hh*(feval(fx,X1,Y1)+feval(fx,X(:,i),Y(:,i)));
   end
end

function [theta,X,Y]=BackEuler(a,b,x0,y0,N,fx,fy)
   h=(b-a)/N;hh=h/2;m=length(y0);
   ep=sqrt(eps);maxit=15;I=eye(m);tol=1e-8;
   theta=a:h:b;X(:,1)=x0;Y(:,1)=y0;
   for i=1:N
     X1 = X(:,i);
     Y1 = Y(:,i);
     % R1 = (Y1 - Y(:, i) - h/2*(feval(fy, X(:,i)+h,Y1)+feval(fy,X(:,i),Y(:,i))));
     % R2 = (X1 - X(:, i) - h/2*(feval(fx, X(:,i),Y1+h)+feval(fx,X(:,i),Y(:,i))));
     R1 = Y1 - Y(:, i) - h*feval(fy, X1,Y1);
     R2 = X1 - X(:, i) - h*feval(fx, X1,Y1);
     for it = 1:maxit 
        for j = 1:m
          Dy(:,j) = (feval(fy,X1,Y1+ep*I(:,j))-feval(fy,X1,Y1-ep*I(:,j)))/(2*ep);
          Dx(:,j) = (feval(fx,X1+ep*I(:,j),Y1)-feval(fx,X1-ep*I(:,j),Y1))/(2*ep);
        end
        Jy  = I - h*Dy;
        Jx  = I - h*Dx;
        dY = -Jy\R1;
        dX = -Jx\R2;
        Y1 = Y1 + dY;
        X1 = X1 + dX;
        R1 = Y1 - Y(:, i) - h*feval(fy, X1,Y1);
        R2 = X1 - X(:, i) - h*feval(fx, X1,Y1);
        if norm([R1,R2],2) < tol*norm([Y1,X1],2);break;end
      end
      %plot(1:it,log10(RS));pause;RS=[];
      if it >=maxit,
          msg=[' WARNING: in step ',num2str(i),' Newton Iteration did not converge in ',num2str(maxit),' iterations ']
      end
      Y(:,i+1)=Y(:,i)+h*feval(fy,X1,Y1);
      X(:,i+1)=X(:,i)+h*feval(fx,X1,Y1);
   end
end
