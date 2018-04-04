function [rkL,rkR,rhL, rhR] = CalculateAnglesfromJoints(Joints)
%CALCULATEANGLES Summary of this function goes here
%   Detailed explanation goes here
[O L]=size(Joints.X);

for j=1:O
% hip,  knee  ankle: 13,17    14,18    15,19
    a=([Joints.X(j,14),Joints.Y(j,14),Joints.Z(j,14)]-[Joints.X(j,13),Joints.Y(j,13),Joints.Z(j,13)]);
    b=([Joints.X(j,14),Joints.Y(j,14),Joints.Z(j,14)]-[Joints.X(j,15),Joints.Y(j,15),Joints.Z(j,15)]);
    rkL(j)=180 - atan2d(norm(cross(a,b)),dot(a,b));
    c=([Joints.X(j,18),Joints.Y(j,18),Joints.Z(j,18)]-[Joints.X(j,17),Joints.Y(j,17),Joints.Z(j,17)]);
    d=([Joints.X(j,18),Joints.Y(j,18),Joints.Z(j,18)]-[Joints.X(j,19),Joints.Y(j,19),Joints.Z(j,19)]);
    rkR(j)=180-atan2d(norm(cross(c,d)),dot(c,d));

% hip angles, hip center = 1
    a=([Joints.X(j,1),Joints.Y(j,1),Joints.Z(j,1)]-[Joints.X(j,2),Joints.Y(j,2),Joints.Z(j,2)]);
    b=([Joints.X(j,13),Joints.Y(j,13),Joints.Z(j,13)]-[Joints.X(j,14),Joints.Y(j,14),Joints.Z(j,14)]);
% mulpiple 
    rhL(j)=180 - atan2d(norm(cross(a,b)),dot(a,b));
    c=([Joints.X(j,1),Joints.Y(j,1),Joints.Z(j,1)]-[Joints.X(j,2),Joints.Y(j,2),Joints.Z(j,2)]);
    d=([Joints.X(j,17),Joints.Y(j,17),Joints.Z(j,17)]-[Joints.X(j,18),Joints.Y(j,18),Joints.Z(j,18)]);
    rhR(j)=180 - atan2d(norm(cross(c,d)),dot(c,d));


end


end

