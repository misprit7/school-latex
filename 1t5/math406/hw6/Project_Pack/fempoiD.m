function u=fempoiD(p,t,e)

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

% Implement homogeneous Dirichlet boundary conditions by forcing the rows and columns
% of stiffness matrix A_mn associated with the edge nodes to be \delta_mn
% A(e,:)=0; A(:,e)=0; f(e)=0;
% A(e,e)=speye(length(e),length(e));
% Implement homogeneous Dirichlet BC at nodes in the vector e by assembling a sub-matrix that is only
% associated with nodes at which the solution is nonzero 
in=(1:N)';                   % vector of all nodes in mesh
ia=setdiff(in,e);            % vector of nodes not in vector e i.e. those that are free
Na=length(ia);               % Na = # of free nodes
Aa=sparse(Na,Na);            % Make space for an abreviated stiffness matrix Aa for only free nodes
Aa=A(ia,ia);                 % Copy the submatrix of A into Ad
fa= zeros(Na,1);             % Forcing vector fa for free nodes 
fa=f(ia);                    % Copy foce vector for free nodes into fa
ua=Aa\fa;                    % solve for solution value at the free nodes
u = zeros(N,1);              % dimension a vector in which to return the solution
u(ia) = ua;                  % copy the non-zero values into the solution vector
