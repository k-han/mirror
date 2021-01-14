function [ pointPEst ] = estimateCameraUsingSVDMethod(points2D, lines3D, indexing, useIndexingForOptimization, pointPMatrixGroundTruth)

fprintf('>>>>> START estimateCameraUsingSVDMethod\n');

if useIndexingForOptimization
    points2D = points2D(:, indexing);
    lines3D = lines3D(:, indexing);
end
numberOfObservations = size(lines3D,2);

A = zeros(numberOfObservations, 18);

for i=1:numberOfObservations
    A(i,:) = kron(points2D(:,i)', rearrangePlueckerVector(lines3D(:,i))');
end

%fprintf('rank of coefficientMatrix = %d.\n', rank(A))

%test for condition number
AA = A'*A;
[UU,DD,VV] = svd(AA);
con = DD(1,1)/DD(18,18);


[U, S, V] = svd(A);
[m, n] = size(V);
sol = V(:, n); %get the last column of V

%put sol into a 3 x 6 matrix
lineP = reshape(sol, 6, 3)';
%

fprintf('   line projection matrix error norm(P_estimation * P_estimation_bar^T) = %d.\n', checkForCorrectness(lineP));
fprintf('   norm(P_estimation) = %f.\n', norm(sol));
fprintf('   norm(A * P_estimation) = %f.\n', norm(A * sol));
linePMatrixGroundTruth = PointPToLineP(pointPMatrixGroundTruth);
linePMatrixGroundTruth = linePMatrixGroundTruth/(norm(linePMatrixGroundTruth));
tmp = linePMatrixGroundTruth';
fprintf('   line projection matrix error norm(P_groundTruth * P_groundTruth_bar^T) = %d.\n', checkForCorrectness(linePMatrixGroundTruth));
fprintf('   norm(P_groundtruth) = %f.\n', norm(linePMatrixGroundTruth));
fprintf('   norm(A * P_groundTruth) = %f.\n', norm(A * tmp(:)));

tmp = PointPToLineP(LinePToPointP(lineP));
tmp = tmp/norm(tmp);
fprintf('   line projection matrix error norm(LinePToPointPToLineP(P_estimation) * LinePToPointPToLineP(P_estimation_bar^T)) = %d.\n', checkForCorrectness(tmp));
fprintf('   norm(LinePToPointPToLineP(P_estimation)) = %f.\n', norm(tmp));
tmp = tmp';
fprintf('   norm(A * LinePToPointPToLineP(P_estimation)) = %f.\n', norm(A * tmp(:)));





pointPEst = LinePToPointP(lineP);

[K1, R1, T1] = decomposeCamera(pointPEst);
pointPEst = constructPointP(K1, R1, T1);

% pointPEst = pointPEst/pointPEst(3, 4); %normalize

fprintf('<<<<< STOP estimateCameraUsingSVDMethod\n')

end



