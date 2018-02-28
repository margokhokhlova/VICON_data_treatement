function [ PRW ] = CalculateAnglesFromOrientations3q( Orientations, index1, index2, index3 )
% index1, index2 - joints between which we are calculating the angle
ow=Orientations.W;
oX=Orientations.X;
oY=Orientations.Y;
oZ=Orientations.Z;
[N,O] = size(ow);

PRW = zeros (3,N);
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
for i=1:N
    q_angle = [ow(i,index1) oX(i,index1) oY(i,index1) oZ(i,index1) ow(i,index2) oX(i,index2) oY(i,index2) oZ(i,index2)];
    res_Q = zeros(1,4);
    res_Q2 = zeros(1,4);
    q_angle2 = [ow(i,index2) oX(i,index2) oY(i,index2) oZ(i,index2) ow(i,index3) oX(i,index3) oY(i,index3) oZ(i,index3)];
    [res_Q(1), res_Q(2), res_Q(3), res_Q(4)] = QuatornianMultiplication(q_angle(1),q_angle(2),q_angle(3),q_angle(4), ...
    q_angle(5), q_angle(6), q_angle(7), q_angle(8));
    [res_Q2(1), res_Q2(2), res_Q2(3), res_Q2(4)] = QuatornianMultiplication(q_angle2(1),q_angle2(2),q_angle2(3),q_angle2(4), ...
    q_angle2(5), q_angle2(6), q_angle2(7), q_angle2(8));
    
    [res_Q(1), res_Q(2), res_Q(3), res_Q(4)] = QuatornianMultiplication(res_Q(1), res_Q(2), res_Q(3), res_Q(4),res_Q2(1), res_Q2(2), res_Q2(3), res_Q2(4));
    

 %    [res_Q] = quatmultiply([ow(i,index1) oX(i,index1) oY(i,index1) oZ(i,index1)], [ow(i,index2) oX(i,index2) oY(i,index2) oZ(i,index2)])
    [PRW(1,i), PRW(2,i), PRW(3,i)] = quat2angle(res_Q);
end

PRW=PRW.*57.2958;
% The left hip was then 
% reoriented by rotating 270° about the x-axis, 270° about the z-axis, and then rotating about the
% y-axis by the previously calculated hip to “hip_center” angle. 
% Similarly, the right hip was reoriented
% by rotating 270° about the x-axis, 90° about the z-axis, and then rotating about the y-axis by the
% previously calculated hip angle. After reorienting the hip coordinates (Fig. 3), the relative
% Cardan angles between the hip (parent) and knee (child) were used to calculate hip angles.
% Knee (parent) and ankle (child) segments were used to calculate knee angles.
% The first Cardan rotation was about the z-axis (flexion/extension), the second was about
% the x-axis (abduction/adduction), and the third was about the y-axis (internal/external). 


% for left foot


end


% %for i=1:N
%     q2= [ow(i,index2) oX(i,index2) oY(i,index2) oZ(i,index2)];
%     q_angle = [ow(i,index1) oX(i,index1) oY(i,index1) oZ(i,index1) quatinv(q2)];
%     res_Q = zeros(1,4);
% 
%     [res_Q(1), res_Q(2), res_Q(3), res_Q(4)] = QuatornianMultiplication(q_angle(1),q_angle(2),q_angle(3),q_angle(4), ...
%     q_angle(5), q_angle(6), q_angle(7), q_angle(8));   
%     [PRW(1,i), PRW(2,i), PRW(3,i)] = quat2angle(res_Q);
% end