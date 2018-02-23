% simple test to compare the data
addpath('G:\MATLAB\toolbox\btk')

acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
markers = btkGetMarkers(acq);

angles = btkGetAngles(acq);

% data from VICON, taken the right joints and substract  the base joint
[V_x, V_y, V_z]  = NormalizeMarkers(markers);
% get data from both Kinects
[t, Joints, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )

% calculate joint angles from coordinates
for j=1:300
      a=([Joints.X(j,14),Joints.Y(j,14),Joints.Z(j,14)]-[Joints.X(j,13),Joints.Y(j,13),Joints.Z(j,13)]);
      b=([Joints.X(j,14),Joints.Y(j,14),Joints.Z(j,14)]-[Joints.X(j,15),Joints.Y(j,15),Joints.Z(j,15)]);
      angle_lkne(j)=atan2d(norm(cross(a,b)),dot(a,b));
      c=([Joints.X(j,18),Joints.Y(j,18),Joints.Z(j,18)]-[Joints.X(j,17),Joints.Y(j,17),Joints.Z(j,17)]);
      d=([Joints.X(j,18),Joints.Y(j,18),Joints.Z(j,18)]-[Joints.X(j,19),Joints.Y(j,19),Joints.Z(j,19)]);
      angle_rkne(j)=atan2d(norm(cross(c,d)),dot(c,d));
      
      a = ([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,13), V_y(j,13), V_z(j,13)]);
      b =([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,15), V_y(j,15), V_z(j,15)]);
      angle_lkne_V(j)=atan2d(norm(cross(a,b)),dot(a,b));

end
figure
subplot(2,1,1)
plot(angle_lkne)
subplot(2,1,2)
plot( angle_lkne_V);     
      
      
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