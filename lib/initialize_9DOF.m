function x0 = initialize_9DOF(iniP)
x0 = zeros(9,1);
[K_0, R_0, T_0, C_0, pp, pv] = decomposecamera(iniP);
x0(1) = (K_0(1) + K_0(5))/2;
x0(2:3) = K_0(7:8);
vec0 = vrrotmat2vec(R_0)';
x0(4:6) = real(vec0(4)*[vec0(1) vec0(2) vec0(3)]);
x0(7:9) = -R_0*C_0;
end