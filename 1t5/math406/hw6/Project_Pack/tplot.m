function tplot(p,t,u)

clf
if nargin<3
  patch('vertices',p,'faces',t,'facecol',[.8,1,.8],'edgecol','k');
else
  patch('vertices',p,'faces',t,'facevertexcdata',u,'facecol','interp', ...
        'edgecol','none');
  colorbar
end
set(gcf,'renderer','zbuffer');
axis equal
drawnow
