function u=fempoi(p,t,e)

% Assemble K and F
N=size(p,1);
A=sparse(N,N);
f=zeros(N,1);
for ielem=1:size(t,1)
  el=t(ielem,:);
  
  Q=[ones(3,1),p(el,:)];
  Area=abs(det(Q))/2;
  c=inv(Q);
    
  Ah=Area*(c(2,:)'*c(2,:)+c(3,:)'*c(3,:));
  fh=Area/3;
  
  A(el,el)=A(el,el)+Ah;
  f(el)=f(el)+fh;
end

% Implement Dirichlet boundary conditions
A(e,:)=0; A(:,e)=0; f(e)=0;
A(e,e)=speye(length(e),length(e));

% Solve
u=A\f;
