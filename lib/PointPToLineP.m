function [ lineP ] = PointPToLineP( P )
% PointPToLineP( P ) transfers the 3x4 point projection matrix P to a 3x6
% line projection matrix lineP
% see paper for a derivation
lineP = [ 
%row1
P(2,3)*P(3,4)-P(2,4)*P(3,3) P(2,4)*P(3,2)-P(2,2)*P(3,4) P(2,2)*P(3,3)-P(2,3)*P(3,2) P(2,1)*P(3,4)-P(2,4)*P(3,1) P(2,1)*P(3,2)-P(2,2)*P(3,1) P(2,1)*P(3,3)-P(2,3)*P(3,1);
%row2
-P(1,3)*P(3,4)+P(1,4)*P(3,3) -P(1,4)*P(3,2)+P(1,2)*P(3,4) -P(1,2)*P(3,3)+P(1,3)*P(3,2) -P(1,1)*P(3,4)+P(1,4)*P(3,1) -P(1,1)*P(3,2)+P(1,2)*P(3,1) -P(1,1)*P(3,3)+P(1,3)*P(3,1);
%row3
P(1,3)*P(2,4)-P(1,4)*P(2,3) P(1,4)*P(2,2)-P(1,2)*P(2,4) P(1,2)*P(2,3)-P(1,3)*P(2,2) P(1,1)*P(2,4)-P(1,4)*P(2,1) P(1,1)*P(2,2)-P(1,2)*P(2,1) P(1,1)*P(2,3)-P(1,3)*P(2,1) 
];

end
