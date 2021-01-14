function [ P_bar ] = rearrangePlueckerMatrix( P )
%rearranges the three rows of the Pluecker Matrix
P_bar(1, :) = rearrangePlueckerVector(P(1,:)')';
P_bar(2, :) = rearrangePlueckerVector(P(2,:)')';
P_bar(3, :) = rearrangePlueckerVector(P(3,:)')';
end
