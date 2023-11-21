
Q=1;C=1;mu=1;w0=1;

alpha = -w0/C/pi^(0.5);
A = Q/(2*pi^(3/2)*C);

tmax = 500;
t = linspace(0,tmax,1000);

R = (2*A/alpha^2*(exp(alpha^2.*t).*erfc(alpha*t.^(1/2))-1)+4*A*t.^(1/2)/alpha/pi^(1/2)).^(0.5);

plot(t, R);
title("Radius over time")

