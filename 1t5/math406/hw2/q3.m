
f1 = @(x)x^(-0.5)*cos(x);
f2 = @(x)f2_func(x);
f3 = @(x)f3_func(x);

c1 = (2*pi)^0.5;
c2 = (2*pi)^0.5-pi^(5/2)/20/2^0.5+pi^(9/2)/1728/2^0.5;

N1 = 2^(4);
N2 = 2^(6);
a = 0;
b = pi/2;

T = zeros(8,2);

T(1,1) = midpoint_rule(f1,a,b,N1)
T(1,2) = midpoint_rule(f1,a,b,N2)

T(2,1) = gauss_legendre(f1,a,b,N1)
T(2,2) = gauss_legendre(f1,a,b,N2)

T(3,1) = midpoint_rule(f2,a,b,N1)+c1
T(3,2) = midpoint_rule(f2,a,b,N2)+c1

T(4,1) = gauss_legendre(f2,a,b,N1)+c1
T(4,2) = gauss_legendre(f2,a,b,N2)+c1

T(5,1) = trapezium_rule(f2,a,b,N1)+c1
T(5,2) = trapezium_rule(f2,a,b,N2)+c1

T(6,1) = midpoint_rule(f3,a,b,N1)+c2
T(6,2) = midpoint_rule(f3,a,b,N2)+c2

T(7,1) = gauss_legendre(f3,a,b,N1)+c2
T(7,2) = gauss_legendre(f3,a,b,N2)+c2

T(8,1) = trapezium_rule(f3,a,b,N1)+c2
T(8,2) = trapezium_rule(f3,a,b,N2)+c2

function ret = f2_func(x)
    if x == 0
        ret = 0;
    else
        ret = x^(-0.5)*(cos(x)-1);
    end
end

function ret = f3_func(x)
    if x == 0
        ret =  0;
    else
        ret = x^(-0.5)*(cos(x)-1+x^2/2-x^4/24);
    end
end

function result = midpoint_rule(f, a, b, N)
    result = 0;
    for i = 0:(N-1)
        point = a+(i+0.5)*(b-a)/N;
        result = result + f(point);
    end

    result = result * (b-a)/N;
end


% function result = trapezium_rule(f, a, b, N)
%     result = 0;
%     for i = 1:(N-1)
%         point = a+i*(b-a)/N;
%         result = result + 2*f(point);
%     end
%     result = result + f(a) + f(b);

%     result = result * (b-a)/N/2;
% end
function result = trapezium_rule(f, a, b, N)
    result = 0;
    for i = 1:N
        left = a+(i-1)*(b-a)/N;
        right = a+i*(b-a)/N;
        result = result + 0.5*(f(left) + f(right)) *(b-a)/N;
    end

    result = result;
end

function result = simpsons_rule(f, a, b, N)
    result = 0;
    for i = 1:N
        left = a+(i-1)*(b-a)/N;
        right = a+i*(b-a)/N;
        result = result + 1/3*(b-a)/N/2*(f(left)+4*f((left+right)/2)+f(right));
    end
end

function result = gauss_legendre(f, a, b, N)
    x = [-sqrt(3/5), 0, sqrt(3/5)];
    w = [5/9, 8/9, 5/9];

    result = 0;
    for i = 1:N
        left = a + (i-1)*(b-a) / N;
        right = a + i*(b-a)/N;
        for j = 1:3
            xi = 0.5*(left+right + (right-left) * x(j));
            result = result+w(j)*f(xi);
        end
    end
    result = 0.5 * (b-a)/N*result;
end
