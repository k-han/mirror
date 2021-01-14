function [normals] = normal2color(normals)
curvec = normals(1,:);
nx = (normals(1,:) - min(curvec(:)))/(max(curvec(:)) - min(curvec(:)))*255;
curvec = normals(2,:);
ny = (normals(2,:) - min(curvec(:)))/(max(curvec(:)) - min(curvec(:)))*255;
curvec = normals(3,:);
nz = (normals(3,:) - min(curvec(:)))/(max(curvec(:)) - min(curvec(:)))*255;
normals(1,:) = nx;
normals(2,:) = ny;
normals(3,:) = nz;
end