function vn=VN(x,y,a)
vn=0;
if abs(y)<0.000001,
   if abs(x)<a,
      vn=-0.5;
   end
else
   vn=(atan2(y,x-a)-atan2(y,x+a))/2/pi;
end
