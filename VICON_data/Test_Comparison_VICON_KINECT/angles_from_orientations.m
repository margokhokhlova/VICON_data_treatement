% final clean code for the calculation of the angles from Kinect
% orientations 
% input: takes one or two orientations and joitns data from Kinect 
% output: Structures hip angle, knee angle with XYZ angles for the dataset

function [Hip_angles, Knee_angles]=angles_from_orientations(Joints, Rotations)
Hip_angles = struc;
Knee_angles =  struc;

% hip,  knee  ankle: 13,17    14,18    15,19  
[N ~]=size(Joints.X);
ThetaInDegrees=zeros(3,N); 
for j=1:N
    u=([Joints.X(j,13),Joints.Y(j,13),Joints.Z(j,13)]-[Joints.X(j,17),Joints.Y(j,17),Joints.Z(j,17)]);
    v=([Joints.X(j,13),Joints.Y(j,13),Joints.Z(j,13)]-[Joints.X(j,1),Joints.Y(j,1),Joints.Z(j,1)]); 
    ThetaInDegrees(1,j)=270/57.2958;
    ThetaInDegrees(2,j) = atan2d(norm(cross(u,v)),dot(u,v))/57.2958;
    ThetaInDegrees(3,j)=270/57.2958;
end
%% visualization
for j=1:N
     VisualizeDCM(Joints, Orientations, j)
end

%% rotate left hip by 270 x axis, 270 - z axis and theta - y axis
%% rotate right hip by 270 x axis, 90 about z axis, theta - y axis
% Z X Y cardan angles from quaternons 


for j=1:N
[quaternion_rotation_hip(1:4)]  = angle2quat(ThetaInDegreesRight(1,j),ThetaInDegreesRight(2,j),ThetaInDegreesRight(3,j),'ZXY');
q_h=[OrientationsL.W(j,13) OrientationsL.X(j,13) OrientationsL.Y(j,13) OrientationsL.Z(j,13)];
q_h_rot= quatmultiply(quatinv(quaternion_rotation_hip),q_h);

q_k=[OrientationsL.W(j,14) OrientationsL.X(j,14) OrientationsL.Y(j,14) OrientationsL.Z(j,14)];
q_a=[OrientationsL.W(j,15) OrientationsL.X(j,15) OrientationsL.Y(j,15) OrientationsL.Z(j,15)];

q_knee = quatmultiply(quatinv(q_a),q_k);
q_hip = quatmultiply(quatinv(q_k), q_h_rot);


% convert to euler coordinates

[rk(1,j) rk(2,j) rk(3,j)] = quat2angle(q_knee, 'ZXY');
[rh(1,j) rh(2,j) rh(3,j)] = quat2angle(q_hip, 'ZXY');
% mul


end
rk=rk.*57.2958;
rh=rh*57.2958;

Hip_angles.X = rh(1,:);
Hip_angles.Y = rh(2,:);
Hip_angles.Z = rh(3,:);

Knee_angles.X = rk(1,:);
Knee_angles.Y = rk(2,:);
Knee_angles.Z = rk(3,:);

end