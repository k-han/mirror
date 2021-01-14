function [ d ] = getDistanceError(points2D, points3D, midPoints3D, otherPoints3D, lines3D, indexing, useIndexingForOptimization, pointPInitialization)

if useIndexingForOptimization
    points2D = points2D(:, indexing);
    lines3D = lines3D(:, indexing);
    points3D = points3D(:, indexing);
    midPoints3D = midPoints3D(:, indexing);
    otherPoints3D = otherPoints3D(:, indexing);
end

pointP = pointPInitialization;

virtualPoints2D = pointP*points3D;
virtualPoints2D = virtualPoints2D./repmat(virtualPoints2D(3,:),[3,1]);
virtualMidPoints2D = pointP*midPoints3D;
virtualMidPoints2D = virtualMidPoints2D./repmat(virtualMidPoints2D(3,:),[3,1]);
virtualotherPoints2D = pointP*otherPoints3D;
virtualotherPoints2D = virtualotherPoints2D./repmat(virtualotherPoints2D(3,:),[3,1]);

numberOfObservations = size(lines3D,2);
Line2D = zeros(3,numberOfObservations);
for i=1:numberOfObservations
        sameLinePoints = [points2D(:,i) virtualPoints2D(:,i) virtualMidPoints2D(:,i) virtualotherPoints2D(:,i)];
        Line2D(:,i) = fitline(sameLinePoints(1:2,:));
end

Scale = sqrt(sum(Line2D(1:2,:).*Line2D(1:2,:),1));
PointLineDistReal = abs(sum(points2D.*Line2D,1))./Scale;
PointLineDistVirtual = abs(sum(virtualPoints2D.*Line2D,1))./Scale;
PointLineDistMidVirtual = abs(sum(virtualMidPoints2D.*Line2D,1))./Scale;
PointLineDistOtherVirtual = abs(sum(virtualotherPoints2D.*Line2D,1))./Scale;
Distance = PointLineDistReal + PointLineDistVirtual + PointLineDistOtherVirtual + PointLineDistMidVirtual;
d=sqrt(sum(Distance(~isnan(Distance))));

end
