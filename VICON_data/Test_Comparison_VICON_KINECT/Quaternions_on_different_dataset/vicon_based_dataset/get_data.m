% get data
addpath('G:\MATLAB\toolbox\btk')
folder = 'E:\datasets\mocap_walk_no_quaternions\walk\normal'
cd(folder);
%files = dir(fullfile(d, '*.jpg'));
fileList = dir ('*.c3d');

%for i=1:numel(names)
acq = btkReadAcquisition('E:\datasets\mocap_walk_no_quaternions\walk\normal\walk-01-normal-aita.c3d');
markers = btkGetMarkers(acq);
angles = btkGetAngles(acq);
[V_x, V_y, V_z]  = NormalizeMarkers(markers);
 Plot3DSelectedJointsSequence( V_x,V_y,V_z );
%end

figure
subplot(2,2,1);
plot(angles.LKneeAngles); title('Left Knee Angle');
subplot(2,2,2)
plot(angles.RKneeAngles); title('Right Knee Angle');
subplot(2,2,3)
plot(angles.LHipAngles); title('Left Hip Angle');
subplot(2,2,4)
plot(angles.RHipAngles); title('Right Knee Angle');

legend('Data from Vicon')

XYZ = struct;
XYZ.X = V_x;
XYZ.Y = V_y;
XYZ.Z = V_z;

