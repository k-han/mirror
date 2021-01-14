function [ pointP ] = getCameraP_9DOF( x )
    alpha = x(1);
    x_0 = x(2);
    y_0 = x(3);
    ax = x(4);
    ay = x(5);
    az = x(6);
    t1 = x(7);
    t2 = x(8);
    t3 = x(9);

    K = [alpha 0     x_0;
         0     alpha y_0;
         0     0     1   ];
    R = vrrotvec2mat([ax ay az norm([ax ay az])]);
    T = [t1; t2; t3];
    pointP = K*[R T];
end