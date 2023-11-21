
n = 10;
a=0; b=10;
h = (b-a)/n;
Q=1;D=1;

exact = @(x) Q./(2*pi*D)*log(b./x);

x = linspace(a,b,n+1);
xe = linspace(a,b,1000);
K = zeros(n);
for i=2:n
    tmp = (x(i-1)+x(i))/2/h;
    K(i,i) = K(i,i) + tmp;
    K(i-1,i-1) = K(i-1,i-1) + tmp;
    K(i,i-1) = K(i,i-1) - tmp;
    K(i-1,i) = K(i-1,i) - tmp;
end

K(n,n) = K(n,n) + (x(n)+x(n+1))/2/h;

b = zeros(1,n);
b(1)=Q/(2*pi*D);

p = [b / K, 0];

figure;
hold on;
plot(xe, exact(xe), 'DisplayName', "Exact")
plot(x, p, 'DisplayName', "Finite Element")
hold off;
title("u(r) vs. r")
legend;

