function [ K_err, translationError, translationDirectionError_inDegrees, rotationError ] = getCameraEstimationErrorKhan( groundTruth, estimation )

[K_gt, R_gt, T_gt, C_gt, pp_gt, pv_gt] = decomposecamera(groundTruth);
[K_est, R_est, T_est, C_est, pp_est, pv_est] = decomposecamera(estimation);

%intrinsics:
K_gt = K_gt/K_gt(9);
K_est = K_est/K_est(9);
K_err = abs(K_gt-K_est);

%extrinsics:
% translationScaleError = (norm(T_est-T_gt))^2 / (norm(T_gt)^2);
if(T_est(3)*T_gt(3) < 0)
    T_est = -T_est;
end
translationError = norm(T_est-T_gt);
cosTheta = dot(T_est,T_gt)/(norm(T_est)*norm(T_gt));
translationDirectionError_inDegrees = acosd(cosTheta);
R = R_gt'*R_est;
vec0 = vrrotmat2vec(R)';
rotationError = vec0(4)/pi*180;
if rotationError > 90
    rotationError = 180 - rotationError;
end
% rotationError = norm(vec0);


end

