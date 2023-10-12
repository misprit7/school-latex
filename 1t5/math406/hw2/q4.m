
f3 = @(r) exp(-r)*besselj(0,3*r)*r;
f5 = @(r) exp(-r)*besselj(0,5*r)*r;

c = [4, 8, 10, 12];
T3 = zeros(1, length(c));
T5 = zeros(1, length(c));

for i = 1:length(c)
    T3(i) = Romberg(f3, 0, c(i), 1e-4, 20);
    T5(i) = Romberg(f5, 0, c(i), 1e-4, 20);
end

plot(c, T3, 'o-', 'DisplayName', 'k=3');
hold on;
plot(c, T5, 's-', 'DisplayName', 'k=5');
hold off;

xlabel('c');
ylabel('I(c)');
title('Plot of I(c) for k=3 and k=5');
legend('Location', 'best');
grid on;

function Integral = Romberg(f,a,b,tol,kmax)
  I = zeros(kmax, kmax+1);
  for s=1:kmax
    I(s,1) = (b-a)/2^(s-1);
    % I(s,2) = trapez(f,a,b,2^(s-1));
  end

  k = 1;
  I(1,2) = trapez(f,a,b,1);
  I_last = I(2,1)+2*tol;
  I_cur = I(2,1);
  while abs(I_cur - I_last) >= tol && k<kmax
    k = k+1;
    I(k,2) = trapez(f,a,b,2^(k-1));
    for m=1:k-1
      I(k-m,m+2) = I(k-m+1,m+1) + (I(k-m+1,m+1)-I(k-m,m+1))/(4^m-1);
    end
    I_last = I_cur;
    I_cur = I(1,k+1);
  end

  Integral = I_last;
  X = a:(b-a)/2^(k-1):b;
end


function result = trapez(f, a, b, N)
    result = 0;
    for i = 1:(N-1)
        point = a+i*(b-a)/N;
        result = result + 2*f(point);
    end
    result = result + f(a) + f(b);

    result = result * (b-a)/N/2;
end

