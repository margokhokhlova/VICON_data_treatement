function [] = VisualizeDCM(Joints, Orientations, index)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% hip,  knee  ankle: 13,17    14,18    15,19 
ow=Orientations.W;
oX=Orientations.X;
oY=Orientations.Y;
oZ=Orientations.Z;
[N,O] = size(ow);
PRW = zeros (3,N);
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
i = index
    q_k = [ow(i,index1) oX(i,index1) oY(i,index1) oZ(i,index1) ];
    q_a=[ow(i,index2) oX(i,index2) oY(i,index2) oZ(i,index2)];

    dcm_k = quat2dcm(q_k);
    dcm_a = quat2dcm(q_a);
    
  
figure    
quiver3(dcm_k(:,1), dcm_k(:,2), dcm_k(:,3), 'r');
hold on 
quiver3(dcm_k(:,1), dcm_k(:,2), dcm_k(:,3),'g');

end
% 
% yaw = pi/6;
% x_v1 = RPY_2_DCM(0,0,yaw)*x_v; %Draw vehicle-1 coordinate frame obtained by right-handed rotation of F_v around z_v
% y_v1 = RPY_2_DCM(0,0,yaw)*y_v;
% z_v1 = RPY_2_DCM(0,0,yaw)*z_v;
% o_v1 = [x_v1'; y_v1'; z_v1'];
% quiver3(zeros(3,1), zeros(3,1), zeros(3,1), o_v1(:,1), o_v1(:,2), o_v1(:,3))