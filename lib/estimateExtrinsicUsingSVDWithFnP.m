function [R,T] = estimateExtrinsicUsingSVDWithFnP(points2D, lines3D, indexing, useIndexingForOptimization,fc, Pc)

if useIndexingForOptimization
    points2D = points2D(:, indexing);
    lines3D = lines3D(:, indexing);
end
points2D = bsxfun(@minus, points2D', Pc)';
numberOfObservations = size(lines3D,2);

A = zeros(numberOfObservations, 18);

for i=1:numberOfObservations
    A(i,:) = kron(points2D(:,i)', rearrangePlueckerVector(lines3D(:,i))');
end

fc_coef = [repmat(fc,[1 12]) repmat(fc*fc,[1 6])];

AA = A'*A;
[UU,DD,VV] = svd(AA);
con = DD(1,1)/DD(18,18);


[U, S, V] = svd(A);
[m, n] = size(V);
sol = V(:, n); %get the last column of V

sol = sol.*(fc_coef');

lineP = reshape(sol, 6, 3)';

pointPEst = LinePToPointP(lineP);

if(pointPEst(3,4) < 0)
    pointPEst = pointPEst./pointPEst(3,4);
end
r1 = pointPEst(1,1:3);
r2 = pointPEst(2,1:3);
r3 = pointPEst(3,1:3);

T = [pointPEst(1,4)./norm(r1);
    pointPEst(2,4)./norm(r2);
    pointPEst(3,4)./norm(r3);];

r1 = r1./norm(r1);
r2 = r2./norm(r2);
r3 = cross(r1,r2);

Q = [r1;  r2; r3];
[U_q, S_q, V_q] = svd(Q);
R = U_q*V_q';

end



