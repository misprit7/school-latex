theta = 0:0.01:2*pi;

z=(2.*exp(2i.*theta)-2)./(exp(1i.*theta)+3);

plot(real(z),imag(z));
axis equal;
grid on;
xlabel("Re(z)");
ylabel("Im(z)");
