function [pointPMatrixEstimation_cross, surf] = estimatePnS( points2D, points3D, midPoints3D, otherPoints3D)
focal_lower = 1000;
focal_upper = 2000;
focal_sample_step = 10;
principlePoint = [640 480]; % init to the image center

sampleRounds = 30;
sampleRate = 0.4;
temp_step = 100;
indexing = 1:temp_step:size(points2D,2);
useIndexingForOptimization = 1;
lines3D = constructPlueckerVectorFromPoints(points3D, otherPoints3D);
d_best = Inf;

fprintf('>>>>> initializating with closed-form solution by SVD ... \n');
%sample focal length for initialization
for fc = focal_lower:focal_sample_step:focal_upper
     K_SVD = [fc 0 principlePoint(1); 0 fc principlePoint(2); 0 0 1 ];
    [ bestindex,  PointP_SVD] = SampleBestSVDwithFocal(sampleRate,sampleRounds, points2D, points3D, midPoints3D, otherPoints3D, lines3D,indexing, useIndexingForOptimization, K_SVD );
    d_current = getDistanceError(points2D, points3D, midPoints3D, otherPoints3D, lines3D, indexing, useIndexingForOptimization, PointP_SVD);
    if d_best > d_current
        d_best  = d_current;
        P_best = PointP_SVD;
    end
end

fprintf('>>>>> optimizating with cross-ratio formuation by Levenberg-Marquardt ... \n');
P_ini = P_best;
[pointPMatrixEstimation_cross, surf] = optimizeByCrossRatio(points2D,[otherPoints3D(1:3,:); midPoints3D(1:3,:); points3D(1:3,:)],P_ini);

fprintf('>>>>> done! \n');
end

