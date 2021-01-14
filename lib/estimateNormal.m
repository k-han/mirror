function [ normals ] = estimateNormal( P, pixels, points3D, otherPoints3D)
%   pixels: 2xn
%   pose1_2d, pose2_2d: 3xn. These are points in the reference plane under
%   Word CS.
[K, R, T, ~, ~, ~] = decomposecamera(P);
points3D = bsxfun(@plus,R*points3D,T);
otherPoints3D = bsxfun(@plus,R*otherPoints3D,T);

pixels = [pixels; ones(1,size(pixels,2))];
%visual ray
V = K\pixels; 
length = sqrt(sum(V.*V, 1));
length = repmat(length, [3, 1]);
V = V./length;
%incident ray
U = points3D - otherPoints3D;
length = sqrt(sum(U.*U, 1));
length = repmat(length, [3, 1]);
U = U./length;

normals = (V + U);
length = sqrt(sum(normals.*normals, 1));
length = repmat(length, [3, 1]);
normals = normals./length;

end

