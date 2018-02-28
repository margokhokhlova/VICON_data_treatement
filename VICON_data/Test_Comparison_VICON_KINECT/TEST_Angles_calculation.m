clc
clear all
%% TEST on ALL Possible Calculations of the angles using quatornions
%% Load and display VICON data

acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
markers = btkGetMarkers(acq);
angles = btkGetAngles(acq);
[V_x, V_y, V_z]  = NormalizeMarkers(markers);


% get data from left Kinect
[t, Joints, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )

[tR, JointsR, OrientationsR ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_r_take1.txt' )


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
plot(Vicon_LKNE_dw); title('Left Knee Angle');
hold on
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
      

%% Calculation of the angles from Markers
% calculate joint angles from coordinates
for j=1:120
      a=([JointsR.X(j,14),JointsR.Y(j,14),JointsR.Z(j,14)]-[JointsR.X(j,13),JointsR.Y(j,13),JointsR.Z(j,13)]);
      b=([JointsR.X(j,14),JointsR.Y(j,14),JointsR.Z(j,14)]-[JointsR.X(j,15),JointsR.Y(j,15),JointsR.Z(j,15)]);
      angle_lkne(j)=180 - atan2d(norm(cross(a,b)),dot(a,b));
      c=([JointsR.X(j,18),JointsR.Y(j,18),JointsR.Z(j,18)]-[JointsR.X(j,17),JointsR.Y(j,17),JointsR.Z(j,17)]);
      d=([JointsR.X(j,18),JointsR.Y(j,18),JointsR.Z(j,18)]-[JointsR.X(j,19),JointsR.Y(j,19),JointsR.Z(j,19)]);
      angle_rkne(j)=180-atan2d(norm(cross(c,d)),dot(c,d));
%       a = ([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,13), V_y(j,13), V_z(j,13)]);
%       b =([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,15), V_y(j,15), V_z(j,15)]);
%       angle_lkne_V(j)=180-atan2d(norm(cross(a,b)),dot(a,b));
%       c = ([V_x(j,18), V_y(j,18), V_z(j,18)]-[V_x(j,17), V_y(j,17), V_z(j,17)]);
%       d =([V_x(j,18), V_y(j,18), V_z(j,18)]-[V_x(j,19), V_y(j,19), V_z(j,19)]);
%       angle_rkne_V(j)=180-atan2d(norm(cross(c,d)),dot(c,d));

end
figure
subplot(1,2,1)
plot(angle_lkne); title('Kinect Left from markers, camera placed right');
subplot(1,2,2)
plot(  angle_rkne);  title('Kinect Right from markers, camera placed right');   
% subplot(2,2,3); 
% plot(angle_lkne_V); title('VICON Left from markers');
% subplot(2,2,4);
% plot(  angle_rkne_V);  title('Kinect Right from markers');   
   %% attempt to make euler angles from it
   for j=1:110
      a = ([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,13), V_y(j,13), V_z(j,13)]);
      b =([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,15), V_y(j,15), V_z(j,15)]);
      r = vrrotvec(a,b);
      c = ([V_x(j,18), V_y(j,18), V_z(j,18)]-[V_x(j,17), V_y(j,17), V_z(j,17)]);
      d =([V_x(j,18), V_y(j,18), V_z(j,18)]-[V_x(j,19), V_y(j,19), V_z(j,19)]);
      r_r = vrrotvec(c,d);
      r=vrrotvec2mat(r);
      r_r=vrrotvec2mat(r_r);
      PRW_al(:,j) = rotationMatrixToEulerAngles(r);
      PRW_al_r(:,j) = rotationMatrixToEulerAngles(r_r);
   end
   PRW_al=(PRW_al);
   PRW_al_r=(PRW_al_r);
figure
subplot(1,2,1);
plot(PRW_al'); title('Left Knee Angle');
subplot(1,2,2)
plot(PRW_al_r'); title('Right Knee Angle');
%% Using the quatornions
      
% hip,  knee  ankle: 13,17    14,18    15,19  
ANGLE_kinect_DCM =CalculateAnglesFromOrientationsViaDCT(Orientations,14, 15);
ANGLE_kinect_R_DCM =CalculateAnglesFromOrientationsViaDCT(Orientations,18, 19);
ANGLE_kinect_DCM = ANGLE_kinect_DCM (:,1:110);
ANGLE_kinect_R_DCM = ANGLE_kinect_R_DCM (:,1:110);

ANGLE_kinect =CalculateAnglesFromOrientations(Orientations,14, 15);
ANGLE_kinect_R =CalculateAnglesFromOrientations(Orientations,18, 19);
ANGLE_kinect = ANGLE_kinect (:,1:110);
ANGLE_kinect_R = ANGLE_kinect_R (:,1:110);

ANGLE_kinect_inv =CalculateAnglesFromOrientations(Orientations,15, 14);
ANGLE_kinect_R_inv =CalculateAnglesFromOrientations(Orientations,19, 18);
ANGLE_kinect_inv = ANGLE_kinect_inv (:,1:110);
ANGLE_kinect_R_inv = ANGLE_kinect_R_inv (:,1:110);

 figure
 subplot(2,2,1)
 plot(ANGLE_kinect'); title('Kinect Left  Knee Ankle via Quaternions');
 subplot(2,2,2)
 plot(ANGLE_kinect_R'); title('Kinect Right   Knee Ankle via Quaternions');
 subplot(2,2,3)
 plot(ANGLE_kinect_DCM'); title('Kinect Left  Knee Ankle via DCM');
 subplot(2,2,4)
 plot(ANGLE_kinect_R_DCM'); title('Kinect Right   Knee Ankle via DCM');
%  
% figure
% subplot(1,2,1)
% plot(ANGLE_kinect_inv'); title('Kinect Left Ankle Knee');
% subplot(1,2,2)
% plot(ANGLE_kinect_R_inv'); title('Kinect Right   Ankle Knee');
% 

%% Using the quatornins for Hip-knee, Knee-ankle
ANGLE_kinect_H =CalculateAnglesFromOrientations3q(Orientations,15, 14, 13);
ANGLE_kinect_R_H =CalculateAnglesFromOrientations3q(Orientations,19, 18, 17);
ANGLE_kinect_H = ANGLE_kinect_H (:,1:110);
ANGLE_kinect_R_H = ANGLE_kinect_R_H (:,1:110);
figure
subplot(2,1,1)
plot(ANGLE_kinect_H'); title('Kinect Left Ankle Knee with Hip');
subplot(2,1,2)
plot(ANGLE_kinect_R_H'); title('Kinect Right Ankle Knee with Hip');

%% Using only single knee quatronion
ANGLE_kinect_K =CalculateAnglesFromOrientations1q(Orientations, 14);
ANGLE_kinect_R_K =CalculateAnglesFromOrientations1q(Orientations, 18);
ANGLE_kinect_K = ANGLE_kinect_K (:,1:110);
ANGLE_kinect_R_K = ANGLE_kinect_R_K (:,1:110);
figure
subplot(2,1,1)
plot(ANGLE_kinect_K'); title('Kinect Left Knee direct');
subplot(2,1,2)
plot(ANGLE_kinect_R_K'); title('Kinect Right  Knee direct');