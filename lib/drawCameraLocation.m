function drawCameraLocation( pointP, color )
%http://stackoverflow.com/questions/8178467/how-to-plot-the-camera-and-image-positions-from-camera-calibration-data
[K, R, T, C, pp, pv] = decomposecamera(pointP);
%define 4 corners on the image plane
w = K(1,3)*2;
h = K(2,3)*2;
a = [0 0 1]';
b = [w 0 1]';
c = [w h 1]';
d = [0 h 1]';
%in world cs
X_a = R'*(K\a - T);
X_b = R'*(K\b - T);
X_c = R'*(K\c - T);
X_d = R'*(K\d - T);

line([X_a(1) X_b(1)], [X_a(2) X_b(2)], [X_a(3) X_b(3)],'Color','c', 'LineStyle', '-');
line([X_b(1) X_c(1)], [X_b(2) X_c(2)], [X_b(3) X_c(3)],'Color','g',  'LineStyle', '-');
line([X_c(1) X_d(1)], [X_c(2) X_d(2)], [X_c(3) X_d(3)],'Color','b',  'LineStyle', '-');
line([X_d(1) X_a(1)], [X_d(2) X_a(2)], [X_d(3) X_a(3)], 'Color','k', 'LineStyle', '-');


line([C(1) X_a(1)], [C(2) X_a(2)], [C(3) X_a(3)],'Color',color,  'LineStyle', '-');
line([C(1) X_b(1)], [C(2) X_b(2)], [C(3) X_b(3)],'Color',color,  'LineStyle', '-');
line([C(1) X_c(1)], [C(2) X_c(2)], [C(3) X_c(3)],'Color',color,  'LineStyle', '-');
line([C(1) X_d(1)], [C(2) X_d(2)], [C(3) X_d(3)],'Color',color,  'LineStyle', '-');



end

