
m = 3;

x = [0, 0.2, 0.3, 0.4, 0.6, 1]
A = x(:).^(0:1:m);
b = (1-x.^2).*sin(x);
y = A \ b'

display(y * 0.5.^(0:1:m))

polyfit(x, b, m)

