function [ newPoints3D ] = GenerateNewPlane( points3D, otherPoints3D, onePointInPlane, PlaneNormal )
% points3D: 3xn
% otherPoints3D: 3xn
% onePointInPlane: 3x1
% PlaneNormal: 3x1
V_line = otherPoints3D - points3D;
V_line = V_line./norm(V_line,1);
t = ((-bsxfun(@minus, points3D(1,:), onePointInPlane(1)))*PlaneNormal(1)+(-bsxfun(@minus, points3D(2,:), onePointInPlane(2)))*PlaneNormal(2)+(-bsxfun(@minus, points3D(3,:), onePointInPlane(3)))*PlaneNormal(3) )./sum(bsxfun(@times, V_line, PlaneNormal),1);
newPoints3D = points3D + V_line.*repmat(t,3,1);
end

