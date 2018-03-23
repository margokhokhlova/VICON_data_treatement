addpath('G:\MATLAB\toolbox\btk')


% Test script to divide the data in cycles
% vicon
acq = btkReadAcquisition('E:\Data_from_CHU\VICON\marche01.c3d');
markers = btkGetMarkers(acq);
[V_x, V_y, V_z]  = NormalizeMarkers(markers);

%-          X correspond à l’axe antéro-postérieur (axe de direction de la marche)

%-          Y correspond à l’axe médio-latéral

%-          Z correspond à l’axe vertical


[O N] = size(V_x);
  for i=1:O
      Plot3DSelectedJoints( V_y(i,:),V_z(i,:),V_x(i,:))
      pause();
  end
   
  
  
% hip,  knee  ankle: 13,17    14,18    15,19  
% figure
% subplot(1,2,1);
% plot(V_z(:,14)); title('Left Knee');
% subplot(1,2,2);
% plot(V_z(:,18)); title('Right Knee');

for j=1:O
      a=([V_x(j,14),V_y(j,14),V_z(j,14)]-[V_x(j,13),V_y(j,13),V_z(j,13)]);
      b=([V_x(j,14),V_y(j,14),V_z(j,14)]-[V_x(j,15),V_y(j,15),V_z(j,15)]);
      angle_lkne(j)=180 - atan2d(norm(cross(a,b)),dot(a,b));
      c=([V_x(j,18),V_y(j,18),V_z(j,18)]-[V_x(j,17),V_y(j,17),V_z(j,17)]);
      d=([V_x(j,18),V_y(j,18),V_z(j,18)]-[V_x(j,19),V_y(j,19),V_z(j,19)]);
      angle_rkne(j)=180-atan2d(norm(cross(c,d)),dot(c,d));
end
figure
subplot(1,2,1)
plot(angle_lkne); title('Vicon left knee angle from markers');
subplot(1,2,2)
plot(  angle_rkne);  title('Vicon right knee angle from markers');   
% subplot(2,2,3); 





 Vicon_cycles = [90, 195];


%%
% test with zeros
[tT, JointsT, OrientationsT ] = LoadJointsFromAtxt('JointsInfo_withZeros.txt' );
%%
% kinect left
% get data from left Kinect
[t, JointsL, Orientations ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_l_take1.txt' )

for j=1:300
  %  Plot3DSelectedJoints(JointsL.X(j,:),JointsL.Y(j,:), JointsL.Z(j,:));
   % pause;
      a=([JointsL.X(j,14),JointsL.Y(j,14),JointsL.Z(j,14)]-[JointsL.X(j,13),JointsL.Y(j,13),JointsL.Z(j,13)]);
      b=([JointsL.X(j,14),JointsL.Y(j,14),JointsL.Z(j,14)]-[JointsL.X(j,15),JointsL.Y(j,15),JointsL.Z(j,15)]);
      angle_lkne(j)=180 - atan2d(norm(cross(a,b)),dot(a,b));
      c=([JointsL.X(j,18),JointsL.Y(j,18),JointsL.Z(j,18)]-[JointsL.X(j,17),JointsL.Y(j,17),JointsL.Z(j,17)]);
      d=([JointsL.X(j,18),JointsL.Y(j,18),JointsL.Z(j,18)]-[JointsL.X(j,19),JointsL.Y(j,19),JointsL.Z(j,19)]);
      angle_rkne(j)=180-atan2d(norm(cross(c,d)),dot(c,d));
%       a = ([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,13), V_y(j,13), V_z(j,13)]);
%       b =([V_x(j,14), V_y(j,14), V_z(j,14)]-[V_x(j,15), V_y(j,15), V_z(j,15)]);
%       angle_lkne_V(j)=180-atan2d(norm(cross(a,b)),dot(a,b));
%       c = ([V_x(j,18), V_y(j,18), V_z(j,18)]-[V_x(j,17), V_y(j,17), V_z(j,17)]);
%       d =([V_x(j,18), V_y(j,18), V_z(j,18)]-[V_x(j,19), V_y(j,19), V_z(j,19)]);
%       angle_rkne_V(j)=180-atan2d(norm(cross(c,d)),dot(c,d));

end
figure
%subplot(1,2,1)
plot(angle_lkne); title('Kinect Left from markers, camera placed left');
%subplot(1,2,2)
%plot(  angle_rkne);  title('Kinect Right from markers, camera placed left');   
% subplot(2,2,3); 

LeftKin_cycles = [1,30, 31, 61, 62, 97];


%%
% kinect right
[t, JointsR, OrientationsR ] = LoadJointsFromAtxt('G:\GitHub\time_alignment\JointsInfo_r_take1.txt' )
for j=1:175
 %Plot3DSelectedJoints(JointsL.X(j,:),JointsL.Y(j,:), JointsL.Z(j,:));
  %  pause;
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

RightKin_cycles = [1,29, 30, 58, 59, 96];


%%
% calculate angle for the first patch 
%  z-axis  (flexion/extension), 
%  x-axis (abduction/adduction)
%  y-axis (internal/external).  
FlexionHipL = zeros(3,40);
AbductionHipL = zeros(3,40);
ExtensionHipL =zeros(3,40);
FlexionHipR = zeros(3,40);
AbductionHipR = zeros(3,40);
ExtensionHipR =zeros(3,40);
FlexionKneeL = zeros(3,40);
AbductionKneeL = zeros(3,40);
ExtensionKneeL =zeros(3,40);
FlexionKneeR = zeros(3,40);
AbductionKneeR = zeros(3,40);
ExtensionKneeR =zeros(3,40);

cycles = LeftKin_cycles;
figure
for m = 1:2:5
n =1;
Orientations = Orientations;
Joints = JointsL;
Orientations_cycle = Orientations;
Orientations_cycle.X=Orientations.X(cycles(m):cycles(m+1),:);Orientations_cycle.Y=Orientations.Y(cycles(m):cycles(m+1),:);
Orientations_cycle.Z=Orientations.Z(cycles(m):cycles(m+1),:); Orientations_cycle.W=Orientations.W(cycles(m):cycles(m+1),:);
Joints_cycle = Joints;
Joints_cycle.X=Joints.X(cycles(m):cycles(m+1),:);Joints_cycle.Y=Joints.Y(cycles(m):cycles(m+1),:);
Joints_cycle.Z=Joints.Z(cycles(m):cycles(m+1),:); 

OrientationsL_changed = reOrientHip(Orientations_cycle, Joints_cycle);

[rkL,rkR,rhL, rhR]=CalculateAngles(OrientationsL_changed);


%
figure
subplot(2,2,1)
plot(rkL');title('Angle Knee Left');
subplot(2,2,2)
plot(rkR');title('Angle Knee Right');
subplot(2,2,3);
plot(rhL'); title('Angle Hip Left');
subplot(2,2,4);
plot(rhR'); title('Angle Hip Right');

clear rkL rkR rhL rhR
 

end
%%


cycles = RightKin_cycles;
Joints=JointsR;
Orientations = OrientationsR;
%JointsL = Joints;


[rkL,rkR,rhL, rhR]=CalculateAngles(OrientationsL_changed);


OrientationsL_changed = reOrientHip(Orientations, Joints);


% save

%
figure

subplot(2,2,1)
plot(rkL');title('Angle Knee Left');
subplot(2,2,2)
plot(rkR');title('Angle Knee Right');
subplot(2,2,3);
plot(rhL'); title('Angle Hip Left');
subplot(2,2,4);
plot(rhR'); title('Angle Hip Right');
suptitle('Right camera data')
clear rkL rkR rhL rhR
 



