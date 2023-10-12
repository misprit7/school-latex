f = @(x)1./(4+x.^2)
[Integral, I, X] = Romberg(f,0,1,0.00001,4)
disp(I)
disp(X)
disp(0.5*atan(0.5))

scatter(X, f(X))
title('Function Evaluation Points for Romberg Integration')

function [Integral,I,X] = Romberg(f,a,b,tol,kmax)
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

