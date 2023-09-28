x = linspace(0, 1, 8);

y = sin(10*x) .* exp(-x.^2);
yp = 10*cos(10*x) .* exp(-x.^2) - 2*x.*sin(10*x) .* exp(-x.^2);

xi = [0.4];


x_dense = linspace(0, 1, 500);
y_dense = sin(10*x_dense) .* exp(-x_dense.^2);
h_dense = hermite(x, y, yp, x_dense);
yp_dense = 10*cos(10*x_dense) .* exp(-x_dense.^2) - 2*x_dense.*sin(10*x_dense) .* exp(-x_dense.^2);

x_approx = x;
y_approx = y;
yp_approx = zeros(length(x_approx),1);
for i = 2:length(x_approx) - 1
    f01 = (y_approx(i)-y_approx(i-1))/(x_approx(i)-x_approx(i-1));
    f12 = (y_approx(i+1)-y_approx(i))/(x_approx(i+1)-x_approx(i));
    f012 = (f12-f01)/(x_approx(i+1)-x_approx(i-1));
    yp_approx(i) = f01+f012*(x_approx(i)-x_approx(i-1));
    if i == 2
        yp_approx(1) = f01+f012*(-x_approx(i)+x_approx(i-1));
    end
    if i == length(x_approx)-1
        yp_approx(end) = f01+f012*(2*x_approx(i+1)-x_approx(i)-x_approx(i-1));
    end
end

h = hermite(x, y, yp_approx, xi);
f = sin(10*xi) .* exp(-xi.^2);
p = pchip_custom(x, y, xi);

display(h)
display(p)

% plot(x_dense, y_dense, x_dense, h, x_dense, p);

% plot(x_dense, yp_dense, x_approx, yp_approx);

function out = pchip_custom(x, y, xq)
    yp = zeros(length(x),1);
    for i = 2:length(x) - 1
        alpha = (2*x(i+1)-x(i)-x(i-1))/3/(x(i+1)-x(i-1));
        f01 = (y(i)-y(i-1))/(x(i)-x(i-1));
        f12 = (y(i+1)-y(i))/(x(i+1)-x(i));
        f012 = (f12-f01)/(x(i+1)-x(i-1));
        % yp(i) = f01+f012*(x(i)-x(i-1));
        if f01*f12 > 0
            yp(i)=f01*f12/(alpha*f12+(1-alpha)*f01);
        else
            yp(i)=0;
        end
        if i == 2
            yp(1) = f01+f012*(-x(i)+x(i-1));
        end
        if i == length(x)-1
            yp(end) = f01+f012*(2*x(i+1)-x(i)-x(i-1));
        end
    end
    out = hermite(x, y, yp, xq);
end

function y_sample = hermite(x, y, yp, xi)
    y_sample = zeros(length(xi), 1);
    for i = 1:length(xi)
        x_cur = xi(i);
        
        for j = 1:length(x) - 1
            if x_cur >= x(j) && x_cur <= x(j + 1)
                break;
            end
        end
        
        delta = x(j+1) - x(j);
        t = (x_cur - x(j)) / delta;
        
        h00 = (1 + 2*t) * (1 - t)^2;
        h10 = t * (1 - t)^2;
        h01 = t^2 * (3 - 2*t);
        h11 = t^2 * (t - 1);
        
        y_sample(i) = h00 * y(j) + h10 * delta * yp(j) + h01 * y(j+1) + h11 * delta * yp(j+1);
    end
end
