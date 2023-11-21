n = 10;
a = 0; b = 1;
h=(b-a)/n;
alpha = 0;
beta = 0;

K = full(gallery('tridiag',n,-1,2,-1));
K(n, n-1) = -1;
K(n, n) = 1;
K = (1/h) * K;

M = full(gallery('tridiag',n,1,4,1));
M(n, n) = 2;
M = (h/6) * M;

[V,D] = eig(K,M);
lambdaFE = diag(D);
eigenvecFE = V;

A = full(gallery('tridiag',n,-1,2,-1));
A(n,n) = 1;
A = A/(h^2);

[V,D] = eig(A);
lambdaDE = diag(D);
eigenvecDE = V;

figure;
scatter(1:n, lambdaFE.^0.5);
hold on;
scatter(1:n, lambdaDE.^0.5);
hold off;
title('Question 1f, k_j vs j')

x = linspace(a, b, n+1);
for i=1:3
    figure;
    hold on;
    plot(x, [0;eigenvecFE(:,i)], 'DisplayName', "Finite Element " + i);
    plot(x, [0;eigenvecDE(:,i)], 'DisplayName', "Difference Equation " + i);
    hold off;
    legend();
end


