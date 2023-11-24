% Circle, all Dirichlet
clear;clf
n=32; phi=2*pi*(0:n)'/n;
pv=[cos(phi),sin(phi)];
[p,t,e]=pmesh(pv,2*pi/n,0);
e=e(p(e,2)==1|p(e,2)==-1)
u=fempoi(p,t,e);
tplot(p,t,u)