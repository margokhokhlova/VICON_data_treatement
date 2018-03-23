% script for left camera data vs vicon
clc
clear all

%% Load and display VICON data
acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
markers = btkGetMarkers(acq);
angles = btkGetAngles(acq);
[V_x, V_y, V_z]  = NormalizeMarkers(markers);

% get data from left Kinect
[t, Joints, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )

%% subsample the data (VICON)
samp_r = round(100/30); 
Vicon_LKNE_dw = downsample(angles.LKneeAngles,samp_r);
Vicon_RKNE_dw  =  downsample(angles.RKneeAngles,samp_r);

Vicon_LHI_dw = downsample(angles.LHipAngles,samp_r);
Vicon_RHI_dw  =  downsample(angles.RHipAngles,samp_r);

Vicon_LANE_dw = downsample(angles.LAnkleAngles,samp_r);
Vicon_RANE_dw  =  downsample(angles.RAnkleAngles,samp_r);
%% DISPLAY REFERENCE
figure
subplot(3,2,1);
plot(Vicon_LKNE_dw(1:90,:)); title('Left Knee Angle Vicon');
subplot(3,2,2);
plot(Vicon_RKNE_dw(1:90,:)); title('Right Knee Angle Vicon');
subplot(3,2,3);
plot(Vicon_LHI_dw(1:90,:)); title('Left Hip Angle Vicon');
subplot(3,2,4);
plot(Vicon_RHI_dw(1:90,:)); title('RightHip Angle Vicon');
subplot(3,2,5);
plot(Vicon_LANE_dw(1:90,:)); title('Left Ankle Angle Vicon');
subplot(3,2,6);
plot(Vicon_RANE_dw(1:90,:)); title('Left Ankle Angle Vicon');

%% Calculate the angles from Left camera. Display

[O N] = size(Orientations.W);

OrientationsL_changed = reOrientHip(Orientations, Joints);
for j=1:90
% VisualizeDCM(Joints, Orientations, j);
 %pause();
% VisualizeDCM(Joints, OrientationsL_changed, j, 'b', Orientations);
% pause();

% hip,  knee  ankle: 13,17    14,18    15,19
q_hL=[OrientationsL_changed.W(j,13) OrientationsL_changed.X(j,13) OrientationsL_changed.Y(j,13) OrientationsL_changed.Z(j,13)];
q_hR=[OrientationsL_changed.W(j,17) OrientationsL_changed.X(j,17) OrientationsL_changed.Y(j,17) OrientationsL_changed.Z(j,17)];

q_kL=[Orientations.W(j,14) Orientations.X(j,14) Orientations.Y(j,14) Orientations.Z(j,14)];
q_aL=[Orientations.W(j,15) Orientations.X(j,15) Orientations.Y(j,15) Orientations.Z(j,15)];

q_kR=[Orientations.W(j,18) Orientations.X(j,18) Orientations.Y(j,18) Orientations.Z(j,18)];
q_aR=[Orientations.W(j,19) Orientations.X(j,19) Orientations.Y(j,19) Orientations.Z(j,19)];

q_Lknee = quatmultiply(quatinv(q_aL),q_kL); % v(q_a),q_k);
q_Rknee = quatmultiply(quatinv(q_aR),q_kR);


q_Lhip = quatmultiply(quatinv(q_kL),q_hL);
q_Rhip = quatmultiply(quatinv(q_kR),q_hR);



% convert to euler coordinates

[rkL(1,j) rkL(2,j) rkL(3,j)] = quat2angle(q_Lknee, 'ZXY');
[rkR(1,j) rkR(2,j) rkR(3,j)] = quat2angle(q_Rknee, 'ZXY');

[rhL(1,j) rhL(2,j) rhL(3,j)] = quat2angle(q_Lhip, 'ZXY');
[rhR(1,j) rhR(2,j) rhR(3,j)] = quat2angle(q_Rhip, 'ZXY');

% mulpiple 
end
rkL=rkL.*57.2958;
rkR=rkR*57.2958;
rhL=rhL.*57.2958;
rhR=rhR*57.2958;

figure 
subplot(2,2,1)
plot(rkL');title('Angle Knee Left');
subplot(2,2,2)
plot(rkR');title('Angle Knee Right');
subplot(2,2,3);
plot(rhL'); title('Angle Hip Left');
subplot(2,2,4);
plot(rhR'); title('Angle Hip Right');


