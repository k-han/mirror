function [ L_bar ] = rearrangePlueckerVector( L )
% rearrangePlueckerVector( L ) rearranges the elements of L
L_bar = [ L(5,:); L(6,:); L(4,:); L(3,:); L(1,:); L(2,:)];
end
