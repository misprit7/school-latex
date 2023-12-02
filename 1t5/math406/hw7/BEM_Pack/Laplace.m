clear;clf;
% Direct BEM solution to Laplaces equation on a circle of radius R
% nabla^2 u = 0 0<=r<R -pi<theta<pi
% with Dirichlet BC u(R,theta) = [ 1 for 0<theta<pi
%                                [ 0 for -pi<theta<0
%
% define elements on the boundary of a circle
N=12;   % Number of line segments
R=10;   % radius of circle
Ns=1:N;
% parameterize the circle
dth=2*pi/N;
th=0:dth:2*pi;
% define beginning points of the line segments
xb=R*cos(th);  
yb=R*sin(th);
% define end points of the line segments
xe=xb*0;ye=yb*0;
xe(1:N-1)=xb(2:N);xe(N)=xb(1);
ye(1:N-1)=yb(2:N);ye(N)=yb(1);
% define midpoints of the line segments
xm=0.5*(xb+xe);
ym=0.5*(yb+ye);
% determine element attributes
ah=0.5*sqrt((xe-xb).^2+(ye-yb).^2);        % half length of element
% determine tangent vectors to elements
calf=0.5*(xe-xb)./ah;                      
salf=0.5*(ye-yb)./ah; 
%generate influence matrices
for i=1:N % sending element
   % global coordinate of current sending element
   xs=xm(i);   
   ys=ym(i);
   % orientation of sending element
   ci=calf(i);
   si=salf(i);
   % half length of sending element
   as=ah(i);
   for j=1:N % receiving element
      % determine relative distance from sending element to receiving element
      x=xm(j)-xs;
      y=ym(j)-ys;
      % rotate to local sending element coordinates
      xp=x*ci+y*si;
      yp=-x*si+y*ci;
      % determine influence matrices
      G(j,i)=V(xp,yp,as);
      H(j,i)=VN(xp,yp,as);
   end
end
% set up boundary values of u
%for i=1:N;
%   u(i)=0;
%   if th(i)>= 0 & th(i) <=pi,
%      u(i)=1;
%   end
%end
u=[0*(1:N/2)+1,0*(1:N/2)]; % quicker
%determine boundary fluxes
p=G\(H*u');
% evaluate the solution at benchmarks
ybm =-R+0.5:0.5:R-0.5;
xbm = 0*ybm;
ubm = 0*xbm;
for i=1:N % sending element
   % global coordinate of current sending element
   xs=xm(i);   
   ys=ym(i);
   % orientation of sending element
   ci=calf(i);
   si=salf(i);
   % half length of sending element
   as=ah(i);
   for j=1:length(ybm)
      % determine relative distance from sending element to receiving benchmark point
      x=xbm(j)-xs;
      y=ybm(j)-ys;
      % rotate to  local sending element coordinates
      xp = x*ci+y*si;
      yp =-x*si+y*ci;
      % accumulate the contributions to the potential at the bechmark point of the current sending element
      ubm(j) = ubm(j)+VN(xp,yp,as)*u(i)-V(xp,yp,as)*p(i);
   end
end
% Determine the exact solution at the benchmarks
rbm = sqrt(xbm.*xbm+ybm.*ybm);thbm=atan2(ybm,xbm);
ue  = 0.5+atan2(2*R*rbm.*sin(thbm),R^2-rbm.^2)/pi;
% Plot solutions 
figure(1);
subplot(2,1,1),plot(xb,yb,xm(Ns),ym(Ns),'o');
axis square
subplot(2,1,2),plot(ybm,ue,'k-',ybm,ubm,'r-o','markersize',2,'markerfacecolor','r')
xlabel('y')
ylabel('u(0,y)')
legend(' Exact Solution ',' Direct BEM ','Location','NorthWest')
title(' Direct boundary integral solution to Laplace Equation: \Deltau=0 along x=0,-10<y<10')
figure(2),plot(ybm,ue-ubm,'r-o','markersize',2,'markerfacecolor','r')
xlabel('y')
ylabel('Error u_ex(0,y)-u(0,y) ')
title(' Direct boundary integral solution to Laplace Equation: \Deltau=0 along x=0,-10<y<10')







      
