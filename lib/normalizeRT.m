function [ RT ] = normalizeRT( RT )

r1 = RT(1,1:3);
r2 = RT(2,1:3);
r3 = RT(3,1:3);

T = [RT(1,4)./norm(r1);
    RT(2,4)./norm(r2);
    RT(3,4)./norm(r3);];

r1 = r1./norm(r1);
r2 = r2./norm(r2);
r3 = r3./norm(r3);

Q = [r1; r2; r3];
[U_q, S_q, V_q] = svd(Q);
 R = U_q*V_q';

 RT = [R T];
end

