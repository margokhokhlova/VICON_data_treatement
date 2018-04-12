% test of BTK functions
acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche 16.c3d');
markers = btkGetMarkers(acq);
% For example, the movement of the center of the knee (KNEE) can be plotted by using:
plot(markers.LKNE);
% 
angles = btkGetAngles(acq);
forces = btkGetForces(acq);
moments = btkGetMoments(acq);
powers = btkGetPowers(acq);

plot(angles.LKneeAngles);

