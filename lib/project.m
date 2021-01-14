function [ xp1, xp2 ] = project( x, y, z, cam )
%PROJECT implements nonlinear model of geometric image formation.
% x,y,z: 2d array of points in world coordinates
% F: frame world -> camera coordinates
% f: focal length 
% c: principle point
% k: radial distortion
% alpha: skew coefficient

% convert to cam frame
xc = x*cam.F(1,1)+y*cam.F(1,2)+z*cam.F(1,3) + cam.F(1,4);
yc = x*cam.F(2,1)+y*cam.F(2,2)+z*cam.F(2,3) + cam.F(2,4);
zc = x*cam.F(3,1)+y*cam.F(3,2)+z*cam.F(3,3) + cam.F(3,4);

% perspective projection
xn1 = xc./zc;
xn2 = yc./zc;

% add radial distortion
r = sqrt(xn1.*xn1 + xn2.*xn2);
dx1 = 2*cam.k(3)*xn1.*xn2 + cam.k(4)*(r.^2 + 2*xn1.^2); 
dx2 = cam.k(3)*(r.^2 + 2*xn2.^2) + 2*cam.k(4)*xn1.*xn2;
fac = (1 + cam.k(1)*r.^2 + cam.k(2)*r.^4 + cam.k(5)*r.^6);
xd1 = fac.*xn1 + dx1;
xd2 = fac.*xn2 + dx2;

% add skew
xp1 = cam.f(1)*(xd1 + cam.alpha*xd2) + cam.c(1);
xp2 = cam.f(2)*xd2 + cam.c(2);

end

