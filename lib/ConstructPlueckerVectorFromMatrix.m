function [ Lvector ] = ConstructPlueckerVectorFromMatrix( Lmatrix )
Lvector = [Lmatrix(1, 2); Lmatrix(1, 3); Lmatrix(1, 4); Lmatrix(2, 3); Lmatrix(3, 4); Lmatrix(4, 2)];
end