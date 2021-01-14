function [ sol, surf] = optimizeByCrossRatio( points2D, points3D, iniP )
global A B C D d AC AB BC A_homo B_homo C_homo
A = points3D(1:3,:);
B = points3D(4:6,:);
C = points3D(7:9,:);
d = points2D(1:2,:);
ptNumber = size(points2D,2);

A_homo = [A; ones(1, ptNumber)];
B_homo = [B; ones(1, ptNumber)];
C_homo = [C; ones(1, ptNumber)];
AC = sqrt(sum((C - A).*(C - A), 1));
AB = sqrt(sum((B - A).*(B - A), 1));
BC = sqrt(sum((C - B).*(C - B), 1));

x0 = initialize_9DOF(iniP);
options.Algorithm = 'levenberg-marquardt';
sol = lsqnonlin('lm_crs_fun',x0,[],[],options);
sol  = getCameraP_9DOF( sol );
surf = D;

end

