% short script for implementaion from the paper by Guess:
JointsL= load('LeftXYZ.mat');
JointsL=JointsL.JointsL;
OrientationsL=load('OrientaionsL.mat');
OrientationsL=OrientationsL.OrientationsL;

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
ThetaInDegreesRight(3,j)=90/57.2958; % we actually make convesion to radians to use the formula in the next section
end
%% rotate left hip by 270 x axis, 270 - z axis and theta - y axis
%% rotate right hip by 270 x axis, 90 about z axis, theta - y axis
% Z X Y cardan angles from quaternons 

for j=1:N
q_h=[OrientationsL.W(j,13) OrientationsL.X(j,13) OrientationsL.Y(j,13) OrientationsL.Z(j,13)];
dcm_qh = quat2dcm (q_h);
dcm_a =  angle2dcm( ThetaInDegreesLeft(1,j), ThetaInDegreesLeft(2,j), ThetaInDegreesLeft(3,j), 'ZXY');
resulting_re_oriented_dcm = dcm_a*dcm_qh;

q_k=[OrientationsL.W(j,14) OrientationsL.X(j,14) OrientationsL.Y(j,14) OrientationsL.Z(j,14)];
dcm_qk = quat2dcm(q_k);

q_a=[OrientationsL.W(j,14) OrientationsL.X(j,14) OrientationsL.Y(j,14) OrientationsL.Z(j,14)];
dcm_qa = quat2dcm(q_k);

dcm_knee = dcm_qa*dcm_qk;
dcm_hip = dcm_qk*(resulting_re_oriented_dcm);
[rk(1,j) rk(2,j) rk(3,j)] = dcm2angle(dcm_knee, 'ZXY');
[rh(1,j) rh(2,j) rh(3,j)] = dcm2angle(dcm_hip, 'ZXY');
% mulpiple 
end
%%
% convert to degrees and plot
rk=rk.*57.2958;
rh=rh*57.2958;
figure 
plot(rk');title('Angle K')
figure
plot(rh'); title('Angle H')

