function [surf_gt, points2D, points3D, midPoints3D, otherPoints3D] = prepare_data(lx, ly, lz, vertices, reproject_xy, noise_std)
%% generate reflection correspondences
% plane positions for the synthetic data: x=1524 mm, x=-1524 mm, y=1524 mm, y=-1524 mm, z = 1524 mm, z = -1524 mm
% split the pixels by reflection planes
index_x = find(lx == -1524);
lx_side_1 = lx(index_x);
ly_side_1 = ly(index_x);
lz_side_1 = lz(index_x);
pixel_x_1 = mod(index_x, 960);
pixel_y_1 = ceil(index_x./960);

index_y = find(ly == -1524);
lx_side_2 = lx(index_y);
ly_side_2 = ly(index_y);
lz_side_2 = lz(index_y);
pixel_x_2 = mod(index_y, 960);
pixel_y_2 = ceil(index_y./960);

index_x = find(lx == 1524);
lx_side_4 = lx(index_x);
ly_side_4 = ly(index_x);
lz_side_4 = lz(index_x);
pixel_x_4 = mod(index_x, 960);
pixel_y_4 = ceil(index_x./960);

index_y = find(ly == 1524);
lx_side_5 = lx(index_y);
ly_side_5 = ly(index_y);
lz_side_5 = lz(index_y);
pixel_x_5 = mod(index_y, 960);
pixel_y_5 = ceil(index_y./960);

index_z = find(lz == 1524);
lx_side_6 = lx(index_z);
ly_side_6 = ly(index_z);
lz_side_6 = lz(index_z);
pixel_x_6 = mod(index_z, 960);
pixel_y_6 = ceil(index_z./960);

% correspondences for side lx == -1524
select_xy = [pixel_y_1 pixel_x_1];
[C,ia,ib] = intersect(select_xy,reproject_xy,'rows');
C = reproject_xy(ib,:);
select_vertices = vertices(ib,:); 
vertex_pixel_index = ib;
surf_gt = select_vertices(:,1:3)';

points2D = [C'; ones(1, size(C,1))];
points3D = [lx_side_1(ia) ly_side_1(ia) lz_side_1(ia) ones(size(C,1),1)]';

onePointInPlane_1 = [-1680 0 0]';
PlaneNormal = [-1 0 0]';
onePointInPlane_2 = [-1800 0 0]';

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_1, PlaneNormal);
midPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_2, PlaneNormal);
otherPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

% add noise for correspnodences
noise_corres = [zeros(1, size(C,1)); normrnd(0, noise_std, [2,size(C,1)]); zeros(1, size(C,1))];
points3D = points3D + noise_corres;
midPoints3D = midPoints3D + noise_corres;
otherPoints3D= otherPoints3D + noise_corres;

surf_gt_tmp = surf_gt;
points2D_tmp = points2D;
points3D_tmp = points3D;
midpoints3D_tmp = midPoints3D;
otherpoints3D_tmp = otherPoints3D;

%% correspondences for side ly == -1524
select_xy = [pixel_y_2 pixel_x_2];
[C,ia,ib] = intersect(select_xy,reproject_xy,'rows');
C = reproject_xy(ib,:);
select_vertices = vertices(ib,:); 
vertex_pixel_index = [vertex_pixel_index; ib];
surf_gt = select_vertices(:,1:3)';

points2D = [C'; ones(1, size(C,1))];
points3D = [lx_side_2(ia) ly_side_2(ia) lz_side_2(ia) ones(size(C,1),1)]';

onePointInPlane_1 = [0 -1680 0]';
PlaneNormal = [0 -1 0]';
onePointInPlane_2 = [0 -1800 0]';

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_1, PlaneNormal);
midPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_2, PlaneNormal);
otherPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

% add noise to correspondence
noise_corres = [normrnd(0, noise_std, [1,size(C,1)]); zeros(1, size(C,1)); normrnd(0, noise_std, [1,size(C,1)]); zeros(1, size(C,1))];
points3D = points3D + noise_corres;
midPoints3D = midPoints3D + noise_corres;
otherPoints3D= otherPoints3D + noise_corres;

surf_gt_tmp = [surf_gt_tmp surf_gt];
points2D_tmp = [points2D_tmp points2D];
points3D_tmp = [points3D_tmp points3D];
midpoints3D_tmp = [midpoints3D_tmp midPoints3D];
otherpoints3D_tmp = [otherpoints3D_tmp otherPoints3D];

%% correspondences for side lx == 1524
select_xy = [pixel_y_4 pixel_x_4];
[C,ia,ib] = intersect(select_xy,reproject_xy,'rows');
C = reproject_xy(ib,:);
select_vertices = vertices(ib,:); 
vertex_pixel_index = [vertex_pixel_index; ib];
surf_gt = select_vertices(:,1:3)';

points2D = [C'; ones(1, size(C,1))];
points3D = [lx_side_4(ia) ly_side_4(ia) lz_side_4(ia) ones(size(C,1),1)]';

onePointInPlane_1 = [1680 0 0]';
PlaneNormal = [1 0 0]';
onePointInPlane_2 = [1800 0 0]';

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_1, PlaneNormal);
midPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_2, PlaneNormal);
otherPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

% add noise to correspondence
noise_corres = [zeros(1, size(C,1)); normrnd(0, noise_std, [1,size(C,1)]); normrnd(0, noise_std, [1,size(C,1)]); zeros(1, size(C,1))];
points3D = points3D + noise_corres;
midPoints3D = midPoints3D + noise_corres;
otherPoints3D= otherPoints3D + noise_corres;

surf_gt_tmp = [surf_gt_tmp surf_gt];
points2D_tmp = [points2D_tmp points2D];
points3D_tmp = [points3D_tmp points3D];
midpoints3D_tmp = [midpoints3D_tmp midPoints3D];
otherpoints3D_tmp = [otherpoints3D_tmp otherPoints3D];

%% correspondences for side ly == 1524
select_xy = [pixel_y_5 pixel_x_5];
[C,ia,ib] = intersect(select_xy,reproject_xy,'rows');
C = reproject_xy(ib,:);
select_vertices = vertices(ib,:); 
vertex_pixel_index = [vertex_pixel_index; ib];
surf_gt = select_vertices(:,1:3)';

points2D = [C'; ones(1, size(C,1))];
points3D = [lx_side_5(ia) ly_side_5(ia) lz_side_5(ia) ones(size(C,1),1)]';

onePointInPlane_1 = [0 1680 0]';
PlaneNormal = [0 1 0]';
onePointInPlane_2 = [0 1800 0]';

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_1, PlaneNormal);
midPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_2, PlaneNormal);
otherPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

% add noise to correspondence
noise_corres = [normrnd(0, noise_std, [1,size(C,1)]); zeros(1, size(C,1)); normrnd(0, noise_std, [1,size(C,1)]); zeros(1, size(C,1))];
points3D = points3D + noise_corres;
midPoints3D = midPoints3D + noise_corres;
otherPoints3D= otherPoints3D + noise_corres;

surf_gt_tmp = [surf_gt_tmp surf_gt];
points2D_tmp = [points2D_tmp points2D];
points3D_tmp = [points3D_tmp points3D];
midpoints3D_tmp = [midpoints3D_tmp midPoints3D];
otherpoints3D_tmp = [otherpoints3D_tmp otherPoints3D];

%% correspondences for side lz == 1524
select_xy = [pixel_y_6 pixel_x_6];
[C,ia,ib] = intersect(select_xy,reproject_xy,'rows');
C = reproject_xy(ib,:);
select_vertices = vertices(ib,:); 
vertex_pixel_index = [vertex_pixel_index; ib];
surf_gt = select_vertices(:,1:3)';

points2D = [C'; ones(1, size(C,1))];
points3D = [lx_side_6(ia) ly_side_6(ia) lz_side_6(ia) ones(size(C,1),1)]';

onePointInPlane_1 = [0 0 1680]';
PlaneNormal = [0 0 1 ]';
onePointInPlane_2 = [0 0 1800]';

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_1, PlaneNormal);
midPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

newPoints3D = GenerateNewPlane( surf_gt, points3D(1:3,:), onePointInPlane_2, PlaneNormal);
otherPoints3D = [newPoints3D; ones(1,size(newPoints3D,2))]; 

% add noise to correspondence
noise_corres = [normrnd(0, noise_std, [1,size(C,1)]); normrnd(0, noise_std, [1,size(C,1)]); zeros(1, size(C,1)); zeros(1, size(C,1))];
points3D = points3D + noise_corres;
midPoints3D = midPoints3D + noise_corres;
otherPoints3D= otherPoints3D + noise_corres;

surf_gt = [surf_gt_tmp surf_gt];
points2D = [points2D_tmp points2D];
points3D = [points3D_tmp points3D];
midPoints3D = [midpoints3D_tmp midPoints3D];
otherPoints3D = [otherpoints3D_tmp otherPoints3D];
end