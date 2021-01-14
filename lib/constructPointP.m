function [ P ] = constructPointP(K, R, T )
P = K*[R T];
end
