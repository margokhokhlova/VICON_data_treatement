clc
clear all

%% TEST on ALL Possible Calculations of the angles using quatornions
%% Load and display VICON data

acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
acq = btkReadAcquisition('E:\datasets\mocap_walk\walk\normal\walk-01-normal-aita.c3d')

markers = btkGetMarkers(acq);
angles = btkGetAngles(acq);
[V_x, V_y, V_z]  = NormalizeMarkers(markers);


% get data from left Kinect
%[t, Joints, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )

%[tR, JointsR, OrientationsR ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_r_take1.txt' )
JointsL= load('G:\GitHub\time_alignment\LeftXYZ.mat');
JointsR= load('G:\GitHub\time_alignment\RightXYZ.mat');
JointsL=JointsL.JointsL;
JointsR=JointsR.JointsR;
OrientationsL=load('G:\GitHub\time_alignment\OrientaionsL.mat');
OrientationsR=load('G:\GitHub\time_alignment\OrientaionsR.mat');
OrientationsL=OrientationsL.OrientationsL;
OrientationsR=OrientationsR.OrientationsR;


%% subsample the data (VICON)
samp_r = round(100/30); 
Vicon_LKNE_dw = downsample(angles.LKneeAngles,samp_r);
Vicon_RKNE_dw  =  downsample(angles.RKneeAngles,samp_r);
V_x=downsample(V_x, samp_r);
V_y=downsample(V_y, samp_r);
V_z=downsample(V_z, samp_r);

%% DISPLAY REFERENCE
figure
subplot(2,1,1);
plot(Vicon_LKNE_dw(1:90,:)); title('Left Knee Angle Vicon');

subplot(2,1,2); plot(rk');  title('Left Knee Angle Kinect');




plot(angle_lkne_V(1:110), '--r'); 
hold off
subplot(2,1,2)
plot(Vicon_RKNE_dw); title('Right Knee Angle');
hold on
plot(  angle_rkne_V(1:110), '--r');  
hold off
legend('Data from Vicon',' recalculated flexion angle')
%%
samp_r = round(100/30); 
Vicon_HKNE_dw = downsample(angles.LHipAngles,samp_r);
Vicon_HRKNE_dw  =  downsample(angles.RHipAngles,samp_r);
figure
subplot(2,1,1);
plot(Vicon_HKNE_dw); title('Right Hip Angle');
subplot(2,1,2)
plot(Vicon_HRKNE_dw); title('Left Hip Angle');


plot(angle_lkne_V); title('VICON Left from markers');
subplot(2,2,4);
plot(  angle_rkne_V);  title('Kinect Right from markers');   
      

%% Calculation of the angles between hip and mid-spine
%hip center: 1      
% hip,  knee  ankle: 13,17    14,18    15,19  
N=24;
ThetaInDegreesLeft=zeros(3,N); ThetaInDegreesRight=zeros(3,N);
JointsL.X;
for j=1:N
u=([JointsL.X(j,13),JointsL.Y(j,13),JointsL.Z(j,13)]-[JointsL.X(j,17),JointsL.Y(j,17),JointsL.Z(j,17)]);
v=([JointsL.X(j,13),JointsL.Y(j,13),JointsL.Z(j,13)]-[JointsL.X(j,1),JointsL.Y(j,1),JointsL.Z(j,1)]); 
ThetaInDegreesLeft(1,j)=270/57.2958;
ThetaInDegreesLeft(2,j) = atan2d(norm(cross(u,v)),dot(u,v))/57.2958;
ThetaInDegreesLeft(3,j)=270/57.2958;
u=([JointsR.X(j,13),JointsR.Y(j,13),JointsR.Z(j,13)]-[JointsR.X(j,17),JointsR.Y(j,17),JointsR.Z(j,17)]);
v=([JointsR.X(j,13),JointsR.Y(j,13),JointsR.Z(j,13)]-[JointsR.X(j,1),JointsR.Y(j,1),JointsR.Z(j,1)]);   
ThetaInDegreesRight(1,j)=270/57.2958;
ThetaInDegreesRight(2,j) = atan2d(norm(cross(u,v)),dot(u,v))/57.2958; 
ThetaInDegreesRight(3,j)=90/57.2958;
end
%% rotate left hip by 270 x axis, 270 - z axis and theta - y axis
%% rotate right hip by 270 x axis, 90 about z axis, theta - y axis
% Z X Y cardan angles from quaternons 


%OrientationsL_changed = reOrientHip(OrientationsL, JointsL);
for j=1:N

VisualizeDCM(JointsL, OrientationsL, j);
pause();
VisualizeDCM(JointsL, OrientationsL_changed, j);
pause();

[quaternion_rotation_hip(1:4)]  = angle2quat(ThetaInDegreesRight(1,j),ThetaInDegreesRight(2,j),ThetaInDegreesRight(3,j),'ZXY');
q_h=[OrientationsL.W(j,13) OrientationsL.X(j,13) OrientationsL.Y(j,13) OrientationsL.Z(j,13)];
q_h_rot= quatmultiply(quatinv(quaternion_rotation_hip),q_h);

q_k=[OrientationsL.W(j,14) OrientationsL.X(j,14) OrientationsL.Y(j,14) OrientationsL.Z(j,14)];
q_a=[OrientationsL.W(j,15) OrientationsL.X(j,15) OrientationsL.Y(j,15) OrientationsL.Z(j,15)];

q_knee = quatmultiply(quatinv(q_a),q_k);
q_hip = quatmultiply(quatinv(q_k), q_h_rot);


% convert to euler coordinates

[rk(1,j) rk(2,j) rk(3,j)] = quat2angle(q_knee, 'ZXY');
[rh(1,j) rh(2,j) rh(3,j)] = quat2angle(q_hip, 'ZXY');
% mulpiple 
end
rk=rk.*57.2958;
rh=rh*57.2958;
figure 
plot(rk');title('Angle K')
figure
plot(rh'); title('Angle H')
