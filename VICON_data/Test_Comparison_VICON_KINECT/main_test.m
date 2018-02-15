% simple test to compare the data
acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
markers = btkGetMarkers(acq);
markers = NormalizeMarkers(markers);

% get data from both Kinects
[t, Joints, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )
