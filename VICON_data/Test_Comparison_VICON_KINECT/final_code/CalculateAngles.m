function [rkL,rkR,rhL, rhR] = CalculateAngles( OrientationsL_changed)
%CALCULATEANGLES Summary of this function goes here
%   Detailed explanation goes here
[O L]=size(OrientationsL_changed.W);

for j=1:O
% VisualizeDCM(Joints, Orientations, j);
 %pause();
% VisualizeDCM(Joints, OrientationsL_changed, j, 'b', Orientations);
% pause();

% hip,  knee  ankle: 13,17    14,18    15,19
q_hL=[OrientationsL_changed.W(j,13) OrientationsL_changed.X(j,13) OrientationsL_changed.Y(j,13) OrientationsL_changed.Z(j,13)];
q_hR=[OrientationsL_changed.W(j,17) OrientationsL_changed.X(j,17) OrientationsL_changed.Y(j,17) OrientationsL_changed.Z(j,17)];

q_kL=[OrientationsL_changed.W(j,14) OrientationsL_changed.X(j,14) OrientationsL_changed.Y(j,14) OrientationsL_changed.Z(j,14)];
q_aL=[OrientationsL_changed.W(j,15) OrientationsL_changed.X(j,15) OrientationsL_changed.Y(j,15) OrientationsL_changed.Z(j,15)];

q_kR=[OrientationsL_changed.W(j,18) OrientationsL_changed.X(j,18) OrientationsL_changed.Y(j,18) OrientationsL_changed.Z(j,18)];
q_aR=[OrientationsL_changed.W(j,19) OrientationsL_changed.X(j,19) OrientationsL_changed.Y(j,19) OrientationsL_changed.Z(j,19)];

q_Lknee = quatmultiply(quatinv(q_aL),q_kL); % v(q_a),q_k);
q_Rknee = quatmultiply(quatinv(q_aR),q_kR);


q_Lhip = quatmultiply((q_kL),(q_hL));
q_Rhip = quatmultiply((q_kR),(q_hR));



% convert to euler coordinates

[rkL(1,j) rkL(2,j) rkL(3,j)] = quat2angle(q_Lknee, 'ZXY');
[rkR(1,j) rkR(2,j) rkR(3,j)] = quat2angle(q_Rknee, 'ZXY');

[rhL(1,j) rhL(2,j) rhL(3,j)] = quat2angle(q_Lhip, 'ZXY');
[rhR(1,j) rhR(2,j) rhR(3,j)] = quat2angle(q_Rhip, 'ZXY');

% mulpiple 
end
g =[-1;1;1];

rkL=rkL.*57.2958.*repmat(g, [1 O]);
rkR=rkR*57.2958;
rhL=rhL.*57.2958.*repmat(g, [1 O]);
g =[-1;1;-1];

rhR=rhR*57.2958.*repmat(g, [1 O]);

end

