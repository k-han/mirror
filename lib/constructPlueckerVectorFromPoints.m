function [ Lvector ] = constructPlueckerVectorFromPoints( Q, P )
% creates from a set of homogeneous points Q and P a set of lines. 
% Q and P are 4xn matrices, where the n columns are n homogeneous points. 
% Lvector is a 3xn matric, where the n columns are n lines. 
[r, c] = size(Q);
for i=1:c
    L_matrix = Q(:, i)*P(:, i)' - P(:, i)*Q(:, i)';
    Lvector(:, i) =  ConstructPlueckerVectorFromMatrix( L_matrix );
end
end


