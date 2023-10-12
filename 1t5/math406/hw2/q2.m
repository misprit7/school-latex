
[Integral, I, X] = Romberg(@(x)1./(4+x.^2),0,1,0.00001,5)
disp(I)
disp(0.5*atan(0.5))

function [Integral,I,X] = Romberg(f,a,b,tol,kmax)
  I = zeros(kmax, kmax+1);
  for s=1:kmax
    I(s,1) = (b-a)/2^(s-1);
    I(s,2) = trapez(f,a,b,2^(s-1));
  end
  err = 2*tol;
  N = 1;
  for m=2:kmax
    N = N*2;
    for s=1:kmax-m+1
      I(s,m+1) = I(s+1,m) + (I(s+1,m)-I(s,m))/(4^(m-1)-1);
    end
  end
  Integral = 0;
  X = 0;
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

