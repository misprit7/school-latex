function v=V(x,y,a)
rp2=(x+a)^2+y^2;
rm2=(x-a)^2+y^2;
v=y*(atan2(y,x-a)-atan2(y,x+a))-0.5*(x-a)*log(rm2)+0.5*(x+a)*log(rp2);
v=v/2/pi;
