function [ bestindex,  best_pointPMatrixEstimation] = SampleBestSVDwithFocal(sampleRate,sampleRounds, points2D, points3D, midPoints3D, otherPoints3D, lines3D,indexing, useIndexingForOptimization, K_SVD )

if useIndexingForOptimization
    points2D = points2D(:, indexing);
    lines3D = lines3D(:, indexing);
    points3D = points3D(:, indexing);
    midPoints3D = midPoints3D(:, indexing);
    otherPoints3D = otherPoints3D(:, indexing);
end

obervationNumber = size(points2D,2);
minErr = Inf;
best_pointPMatrixEstimation = eye(3,4);
bestindex = indexing;
for i = 1:sampleRounds
      indexing = sort(randsample(1:obervationNumber,round(sampleRate*obervationNumber)));
      [R_SVD,T_SVD] = estimateExtrinsicUsingSVDWithFnP(points2D, lines3D, indexing, useIndexingForOptimization,K_SVD(1), [K_SVD(1,3) K_SVD(2,3) 0]);
      RT_SVD = normalizeRT([R_SVD, T_SVD]);
      PointP_SVD = K_SVD*RT_SVD;
      DistanceError = getDistanceError(points2D, points3D, midPoints3D, otherPoints3D, lines3D, indexing, useIndexingForOptimization, PointP_SVD);
    if minErr > DistanceError
        minErr = DistanceError;
        best_pointPMatrixEstimation = PointP_SVD;
        bestindex = indexing;
    end
end

end



