function fval = lm_crs_fun(x)
    global A B C D d AC AB BC A_homo B_homo C_homo inlier_index

    P = getCameraP_9DOF(x);
    a_homo = P*A_homo;
    a_homo = a_homo./repmat(a_homo(3,:),[3,1]);
    b_homo = P*B_homo;
    b_homo = b_homo./repmat(b_homo(3,:),[3,1]);
    c_homo = P*C_homo;
    c_homo = c_homo./repmat(c_homo(3,:),[3,1]);

    a = a_homo(1:2,:);
    b = b_homo(1:2,:);
    c = c_homo(1:2,:);

    ac = sqrt(sum((c - a).*(c - a), 1));
    ad = sqrt(sum((d - a).*(d - a), 1));
    bc = sqrt(sum((c - b).*(c - b), 1));
    bd = sqrt(sum((d - b).*(d - b), 1));

    AD = (AC.*AB.*bc.*ad)./(AC.*bc.*ad - ac.*bd.*BC);
    
    %filter out outliers
    inlier_index_upper = find(abs(AD) < 2*mean(abs(AD)));
    inlier_index_lower = find(abs(AD) > 0.2*mean(abs(AD)));

    inlier_index = intersect(inlier_index_upper,inlier_index_lower);
    
    V = (C - A)./repmat(sqrt(sum((C-A).*(C-A),1)),[3,1]);
    D = A + V.*repmat(AD,[3 1]);
    D_homo = [D; ones(1,size(V,2))];
    d_e_homo = P*D_homo;
    d_e_homo = d_e_homo./repmat(d_e_homo(3,:),[3,1]);
    d_e = d_e_homo(1:2,:);
    fval = sum((d-d_e).*(d-d_e),1);

end