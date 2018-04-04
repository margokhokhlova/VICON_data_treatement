% simple test to compare the data
addpath('G:\MATLAB\toolbox\btk')

acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
markers = btkGetMarkers(acq);

angles = btkGetAngles(acq);

% data from VICON, taken the right joints and substract  the base joint
[X, Y, Z]  = NormalizeMarkers(markers);
% get data from both Kinects
%[t, Joints, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )
XYZ = struct;
XYZ.X=X;
XYZ.Y=Y;
XYZ.Z=Z;
% calculate joint angles from coordinates
[angle_lkne_V,angle_rkne_V,angle_lhip_V, angle_rhip_V]=CalculateAnglesfromJoints( XYZ);

%% DISPLAY REFERENCE
figure
subplot(2,2,1);
plot(angles.LKneeAngles); title('Left Knee Angle');
hold on
plot(angle_lkne_V, '--r'); 
hold off
subplot(2,2,2)
plot(angles.RKneeAngles); title('Right Knee Angle');
hold on
plot(  angle_rkne_V, '--r');  
hold off
subplot(2,2,3);
plot(angles.LHipAngles); title('Left Hip Angle');
hold on
plot(angle_lhip_V, '--r'); 
hold off
subplot(2,2,4)
plot(angles.RHipAngles); title('Right Hip Angle');
hold on
plot(angle_rhip_V, '--r');  
hold off
legend('Data from Vicon',' recalculated flexion angle')



%%

ANGLE_kinect =CalculateAnglesFromOrientations(Orientations,14, 15);

ANGLE_kinect_R =CalculateAnglesFromOrientations(Orientations,18, 19);
ANGLE_kinect = ANGLE_kinect (:,1:120);
ANGLE_kinect_R = ANGLE_kinect_R (:,1:120);

figure
subplot(2,1,1)
plot(ANGLE_kinect')
subplot(2,1,2)
plot(ANGLE_kinect_R');


%% subsample the data
samp_r = round(100/30); 
Vicon_LKNE_dw = downsample(Vicon_LKNE,samp_r);
Vicon_LKNE = angles.LKneeAngles;

%%
% low-pass filter with cutoff frequency 6 Hz  KINECT
cutOff = 6;
frequencySample = 30;
Normalized = cutOff * 2 / frequencySample ;
[b,a] = butter(2,Normalized,'low')
ANGLE_kinect_filtered = filter(b,a, ANGLE_kinect);
% low pass and  downsample the VICON data (from 100 to 30 hz).

samp_r = 100/30; 
y = downsample(x,n)


% time syncronization: the vicon data were shifted such that the knee angle
% error is  minimazed



%%
figure
subplot(2,1,1);
plot(angles.RKneeAngles); title('Right Knee Angle');
subplot(2,1,2)
plot(angles.LKneeAngles); title('Left Knee Angle');