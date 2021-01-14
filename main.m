% Reconstruct the mirror Hood shape (w/ noisy reflection correspondences)

clear
close all
clc
addpath(genpath('./.'))

%% prepare data
% read light map
[lx,ly,lz] = read_vtk('./data/l00.vtk');
% read camera parameters
cam = read_cam_params('./data/cam.txt');
% read ground truth
vertices = load('./data/ground_truth.xyz');
% read the image
curimg = imread('./data/hood.png');
[rr,cc,hh] = size(curimg);
mask = imread('./data/hood_mask.png');
mask = (mask > 0);

% std for the noise added on reflection correspondences
noise_std = 0.5;

lx = lx.*mask;
ly = ly.*mask;
lz = lz.*mask;

% project the vertices to the image
[ xp1, xp2 ] = project(vertices(:,1), vertices(:,2), vertices(:,3), cam);
tmp = cam.F(1:3,1:4)*[vertices(:,1:3) ones(size(vertices,1),1)]';
% get the kmatrix
kmat = [cam.f(1) 0  cam.c(1);0 cam.f(2) cam.c(2);0 0 1];
tmppixel = kmat*tmp;
tmpx = tmppixel(1,:)./tmppixel(3,:);
tmpy = tmppixel(2,:)./tmppixel(3,:);
reproject_xy = ceil([tmpx' tmpy']);

%ground truth Projection Matrix
pointPMatrixGroundTruth = kmat*cam.F(1:3,1:4);

figure(1),
imshow(curimg);
hold on
plot(reproject_xy(:, 1),reproject_xy(:, 2),'r.')
set(gca,'FontSize', 13)
title('Hood shape: 2D pixels')

[surf_gt, points2D, points3D_gt, midPoints3D_gt, otherPoints3D_gt] = prepare_data(lx, ly, lz, vertices, reproject_xy, 0);

[~, ~, points3D_noisy, midPoints3D_noisy, otherPoints3D_noisy] = prepare_data(lx, ly, lz, vertices, reproject_xy, noise_std);

%% estimate projection matrix and 3D surface points
[pointPMatrixEstimation, surf_est] = estimatePnS( points2D, points3D_noisy, midPoints3D_noisy, otherPoints3D_noisy);

%% estimate normals
normal_gt  = estimateNormal(pointPMatrixGroundTruth, points2D(1:2,:), points3D_gt(1:3,:), otherPoints3D_gt(1:3,:) );
normal_color_gt = normal2color(normal_gt);
normal_est = estimateNormal(pointPMatrixEstimation, points2D(1:2,:), points3D_noisy(1:3,:), otherPoints3D_noisy(1:3,:));
normal_color_est = normal2color(normal_est);

%% evaluate errors
[ error_surf, error_surf_rms ] = getReconError( surf_gt, surf_est );

[K_gt, R_gt, T_gt, C_gt, pp_gt, ~] = decomposecamera(pointPMatrixGroundTruth);

[K_est, R_est, T_est, C_est, pp_est, ~] = decomposecamera(pointPMatrixEstimation);

[error_K, error_T_scale, error_T_Deg, error_R_deg ] = getCameraEstimationError( pointPMatrixEstimation, pointPMatrixGroundTruth );

error_K_ratio = error_K./K_gt .* 100;


%% visualization
figure(2)
hold on
scatter3(surf_est(1,:),surf_est(2,:),surf_est(3,:), 5, surf_est(3,:),'filled')
colormap(jet);
campos([10500, 4330, 3200]);
set(gca,'FontSize', 13)
axis equal
title('Point cloud: reconstruction')

figure(3)
hold on
scatter3(surf_gt(1,:),surf_gt(2,:),surf_gt(3,:), 5, surf_gt(3,:),'filled')
colormap(jet);
campos([10500, 4330, 3200]);
set(gca,'FontSize', 13)
axis equal
title('Point cloud: ground truth')

figure(4)
hold on
scatter3(surf_gt(1,:),surf_gt(2,:),surf_gt(3,:),5,error_surf,'filled')
colormap(jet);
colorbar('southoutside')
caxis([0, 15]);
set(gca,'FontSize', 13)
campos([10500, 4330, 3200]);
axis equal
title('Point cloud: error')

figure(5)
title('Normal: ground truth')
hold on
scatter3(surf_gt(1,:),surf_gt(2,:),surf_gt(3,:),5,normal_color_gt'/255,'filled')
set(gca,'FontSize', 13)
campos([10500, 4330, 3200]);
set(gca,'visible', 'off')
axis equal
title('Normal: ground truth')
axis off

figure(6)
hold on
scatter3(surf_gt(1,:),surf_gt(2,:),surf_gt(3,:),5,normal_color_est'/255,'filled')
set(gca,'FontSize', 13)
campos([10500, 4330, 3200]);
set(gca,'visible', 'off')
axis equal
title('Normal: estimation')
axis off

cosValue = dot(normal_gt,normal_est);
angles = acosd(cosValue);
figure(7)
hold on
scatter3(surf_gt(1,:),surf_gt(2,:),surf_gt(3,:),5,angles,'filled')
colormap(jet);
colorbar('southoutside')
set(gca,'FontSize', 13)
campos([10500, 4330, 3200]);
set(gca,'visible', 'off')
axis equal
title('Normal: error')
axis off

figure(8)
hold on
drawCameraLocation(pointPMatrixGroundTruth,'g');
drawCameraLocation(pointPMatrixEstimation,'r');
set(gca,'FontSize', 13)
campos([10500, 4330, 3200]);
axis equal
title('Camera: estimation (green) vs GT (red)')

