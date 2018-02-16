% simple test to compare the data
acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
markers = btkGetMarkers(acq);
markers = NormalizeMarkers(markers);

% data from VICON, taken the right joints and substract  the base joint
[V_x, V_y, V_z]  = NormalizeMarkers(markers);
% get data from both Kinects
[t, Joints, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )

ANGLE_kinect =CalculateAnglesFromOrientations(Orientations,14, 15);




