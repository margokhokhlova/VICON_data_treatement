function [ OrientationsL ] = reOrientHip( OrientationsL, JointsL )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% To  convert  the  Kinect  skeletal  orientations  to  relative  Cardan  angles,  the  following procedures were performed. 
% First, the angle between a line from “hip_left” to “hip_right” and a line from either the left or right hip to “hip_center” was calculated
% at each time step. The left hip was then reoriented  by  rotating  270° about  the  x-axis,  270° about  the  z-axis ,  and  then 
% rotating about the  y-axis by the previously calculated hip to “hip_center” angle.  Similarly, the right hip was reoriented by rotating
% 270° about the x-axis, 90° about the z-axis, and then rotating about the y-axis by the previously calculated hip angle. 
% After reorienting the hip coordinates (Fig. 3) , the relative  Cardan angles between  the  hip  (parent) 
% and  knee  (child) were used to  calculate hip angles.  Knee (parent) and ankle (child) segments were used to calculate knee angles.  
% The first Cardan  rotation  was  about  the  z-axis  (flexion/extension),  the  second was about  the  x-axis (abduction/adduction),
% and the third was about the y-axis (internal/external)
[N O] = size(OrientationsL.W);

% Get rotation angles for hip quaternions 
for j = 1:1:N
    
% hip,  knee  ankle: 13,17    14,18    15,19  
u=([JointsL.X(j,13),JointsL.Y(j,13),JointsL.Z(j,13)]-[JointsL.X(j,17),JointsL.Y(j,17),JointsL.Z(j,17)]);
v=([JointsL.X(j,13),JointsL.Y(j,13),JointsL.Z(j,13)]-[JointsL.X(j,1),JointsL.Y(j,1),JointsL.Z(j,1)]); 
ThetaInDegreesLeft(1,j)=270/57.2958;
ThetaInDegreesLeft(2,j) = atan2d(norm(cross(u,v)),dot(u,v))/57.2958;
ThetaInDegreesLeft(3,j)=270/57.2958;

u=([JointsL.X(j,13),JointsL.Y(j,13),JointsL.Z(j,13)]-[JointsL.X(j,17),JointsL.Y(j,17),JointsL.Z(j,17)]);
v=([JointsL.X(j,17),JointsL.Y(j,17),JointsL.Z(j,17)]-[JointsL.X(j,1),JointsL.Y(j,1),JointsL.Z(j,1)]); 
ThetaInDegreesRight(1,j)=270/57.2958;
ThetaInDegreesRight(2,j) = atan2d(norm(cross(u,v)),dot(u,v))/57.2958;
ThetaInDegreesRight(3,j)=90/57.2958;


%vRHS(i,:) = [Centroid(i,49)-Centroid(i,55),Centroid(i,50)-Centroid(i,56),Centroid(i,51)-Centroid(i,57)];
%vRHLH(i,:) = [Centroid(i,52)-Centroid(i,55),Centroid(i,53)-Centroid(i,56),Centroid(i,54)-Centroid(i,57)];
%ThetaR(i,1) = atan2d(norm(cross(vRHS(i,:),vRHLH(i,:))),dot(vRHS(i,:),vRHLH(i,:)));
%vLHS(i,:) = [Centroid(i,49)-Centroid(i,52),Centroid(i,50)-Centroid(i,53),Centroid(i,51)-Centroid(i,54)];
%vLHRH(i,:) = [Centroid(i,55)-Centroid(i,52),Centroid(i,56)-Centroid(i,53),Centroid(i,57)-Centroid(i,54)];
%ThetaR(i,2) = atan2d(norm(cross(vLHS(i,:),vLHRH(i,:))),dot(vLHS(i,:),vLHRH(i,:)));
end
RHipRot = nanmean(ThetaInDegreesRight(2,:));
LHipRot = nanmean(ThetaInDegreesLeft(2,:));

%Rotate Hip Quaternions

LHA = [270*pi/180, 270*pi/180, -LHipRot*pi/180];
a1 = angle2quat(LHA(1),LHA(2),LHA(3),'XZY');

RHA = [270*pi/180, 90*pi/180, RHipRot*pi/180];
a2 = angle2quat(RHA(1),RHA(2),RHA(3),'XZY');

for j=1:N
%% rotate left hip by 270 x axis, 270 - z axis and theta - y axis
%% rotate right hip by 270 x axis, 90 about z axis, theta - y axis
% Z X Y cardan angles from quaternons 

q_h_l=[OrientationsL.W(j,13) OrientationsL.X(j,13) OrientationsL.Y(j,13) OrientationsL.Z(j,13)];
q_h_lrot= quatmultiply(q_h_l, a1);
q_h_r = [OrientationsL.W(j,17) OrientationsL.X(j,17) OrientationsL.Y(j,17) OrientationsL.Z(j,17)];
q_h_rrot= quatmultiply(q_h_r, a2);


OrientationsL.W(j,13) = q_h_lrot(1);
OrientationsL.X(j,13) = q_h_lrot(2);
OrientationsL.Y(j,13) = q_h_lrot(3);
OrientationsL.Z(j,13) = q_h_lrot (4);
OrientationsL.W(j,17) =q_h_rrot (1);
OrientationsL.X(j,17) = q_h_rrot(2);
OrientationsL.Y(j,17) =q_h_rrot(3);
OrientationsL.Z(j,17) =q_h_rrot(4);





end

